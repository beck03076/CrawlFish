class CreateProcedurePJumpUpdate < ActiveRecord::Migration
  def up
  execute "DROP PROCEDURE IF EXISTS p_jump_update"

    execute <<-SQL
    CREATE PROCEDURE p_jump_update(IN v_cols VARCHAR(255),
                        IN p_cat VARCHAR(50),
                        IN p_bran TEXT,
                        IN p_bran_name VARCHAR(50),
                        IN v_id INT, 
                        IN v_del INT,
                        IN v_type VARCHAR(10),
                        IN d_id VARCHAR(255),
                        IN p_price DOUBLE,
                        IN p_avl VARCHAR(255),
                        IN p_del_cost DOUBLE,
                        IN p_del_time VARCHAR(255),
                        IN p_offers TEXT,
                        IN p_warr TEXT,
                        IN p_del CHAR(1),
                        IN reason VARCHAR(255),
                        IN valid VARCHAR(255),
                        IN conf_by VARCHAR(255),
                        IN t DATETIME)
BEGIN
     
     DECLARE cursor_end CONDITION FOR SQLSTATE '02000';
     DECLARE done INT DEFAULT 0;
     DECLARE p_id,p_url,p_name,p_id1,p_id2,v_name VARCHAR(500);
     DECLARE d_id2 TEXT;
     DECLARE dt DATETIME;
     
     
     DECLARE cur_products CURSOR FOR SELECT * from t_view;
     DECLARE CONTINUE HANDLER FOR cursor_end SET done = 1;
     
     DROP VIEW IF EXISTS t_view;
     DROP VIEW IF EXISTS t_view_one;
     
     SELECT now() INTO @start;
     
     SELECT vendor_name INTO v_name
     FROM vendors_lists 
     WHERE vendor_id = v_id;
     
     SET @query = CONCAT('CREATE VIEW t_view_one as SELECT IFNULL(updated_at,created_at) as dt,',v_cols, ' from ',p_cat,' where ',p_bran_name,' IN (',p_bran,')'); 
     SELECT @query as msg;
     PREPARE stmt from @query; 
     EXECUTE stmt; 
     DEALLOCATE PREPARE stmt;
     
     SET @query = CONCAT('CREATE VIEW t_view as SELECT * from t_view_one WHERE dt > "',t,'"'); 
     SELECT @query as msg;     
     PREPARE stmt from @query; 
     EXECUTE stmt; 
     DEALLOCATE PREPARE stmt;
     
     SELECT COUNT(*) INTO @v_c 
     FROM t_view;
     SET @msg1 = CONCAT('There are about ',@v_c, ' records to be processed..');
     SELECT @msg1;
     
     SET @msg1 = CONCAT('Processing for vendor_name - ',UPPER(v_name),' with vendor_id - ',v_id);
     SELECT @msg1;
     
     OPEN cur_products; 
        FETCH cur_products INTO dt,p_id,p_url,p_name,p_id1,p_id2;
        
        WHILE done = 0 DO 
        
        SET @msg2 =  CONCAT('Processing ',p_name,'..........');
        SELECT @msg2;
        
        SET d_id2 = CONCAT(d_id,"-product-id-name-",p_id,"-",p_name);
      
       call p_insert_update_delete_products_table(v_del,
                                                   d_id2,
                                                   v_type,
                                                   v_id,
                                                   p_id,
                                                   p_name,
                                                   p_url,
                                                   p_cat,
                                                   p_cat,
                                                   p_id1,
                                                   p_id2,
                                                   p_price,
                                                   p_avl,
                                                   p_del_cost,
                                                   p_del_time,
                                                   p_offers,
                                                   p_warr,
                                                   NULL,
                                                   p_del,
                                                   reason,
                                                   valid,
                                                   conf_by);

        
        FETCH cur_products INTO dt,p_id,p_url,p_name,p_id1,p_id2;
        END WHILE; 
     CLOSE cur_products; 
     
     SELECT now() INTO @end;
     SELECT abs(timediff(@end,@start)) INTO @diff;
     SET @take = @diff * @v_c;
     SELECT CONCAT('It took ',@take,' seconds to process ',@v_c, ' records..') as msg;
     
    END;
    SQL
  end

  def down
  execute "DROP PROCEDURE IF EXISTS p_jump_update"
  end
end
