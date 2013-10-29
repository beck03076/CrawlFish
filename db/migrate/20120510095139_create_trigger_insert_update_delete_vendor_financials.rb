class CreateTriggerInsertUpdateDeleteVendorFinancials < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS monetization.t_update_vendor_financials"

    execute <<-SQL
    CREATE TRIGGER monetization.t_update_vendor_financials AFTER UPDATE ON monetization.vendor_financials
    FOR EACH ROW
    BEGIN

    	DECLARE v_DebugID VARCHAR(255) DEFAULT 't_update_vendor_financials';
	DECLARE v_fixed_amount DOUBLE;
	DECLARE v_subscribed_date, v_current_date DATE;

	/*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
	call debug.debug_on(v_DebugID);

	IF new.history_flag = 0 THEN

    	/* Insert a record in debug table for tracking the events */
    	call debug.debug_insert(v_DebugID,concat("Changing the trial_flag of vendor_id ",new.vendor_id," to N"));

	UPDATE crawlfishdevdb.vendors_lists SET trial_flag = "n" WHERE vendor_id = new.vendor_id;


	SET v_current_date = CURRENT_TIMESTAMP;

  	/* Insert a record in debug table for tracking the events */
    	call debug.debug_insert(v_DebugID,"Selecting the transaction amount from vendor transactions");

	SELECT transaction_amount INTO v_fixed_amount FROM vendor_transactions
	WHERE vendor_financial_id = new.vendor_financial_id AND vendor_id = new.vendor_id;

  	/* Insert a record in debug table for tracking the events */
    	call debug.debug_insert(v_DebugID,"Setting the subscribed_date");

	IF v_current_date > new.cut_off_date THEN
		
		SET v_subscribed_date = v_current_date;
	
	ELSEIF v_current_date <= new.cut_off_date THEN

		SET v_subscribed_date = new.cut_off_date + 1;
		
	END IF;

  	/* Insert a record in debug table for tracking the events */
    	call debug.debug_insert(v_DebugID,"Updating the fixed_pay_vendors table");

	UPDATE crawlfishdevdb.fixed_pay_vendors SET accepted_amount = v_fixed_amount,
				     period = 30,
				     subscribed_date = v_subscribed_date,
				     cut_off_period = 10
	WHERE vendor_id = new.vendor_id;

	ELSE

	/* Insert a record in debug table for tracking the events */
    	call debug.debug_insert(v_DebugID,concat("History flag set to 1 for vendor id ",new.vendor_id));

	END IF;

   	/* Ending the debug table insert with a #(pound) mark */
    	call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TRIGGER monetization.t_update_vendor_financials"
  end
end
