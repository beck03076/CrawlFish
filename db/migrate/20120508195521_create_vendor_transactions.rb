class CreateVendorTransactions < ActiveRecord::Migration
  def up

    execute "DROP TABLE IF EXISTS monetization.vendor_transactions"

    execute <<-SQL
    CREATE TABLE monetization.vendor_transactions (
    vendor_transaction_id INT UNSIGNED AUTO_INCREMENT,
    vendor_id INT UNSIGNED NOT NULL,
    vendor_financial_id INT UNSIGNED NOT NULL,
    transaction_amount DOUBLE NOT NULL,
    transaction_currency VARCHAR(255) NOT NULL,
    transaction_type VARCHAR(255) NOT NULL,
    transaction_bank VARCHAR(255) NOT NULL,
    bank_branch VARCHAR(255) NOT NULL,
    bank_city VARCHAR(255) NOT NULL,
    bank_state VARCHAR(255) NOT NULL,
    transaction_date DATE NOT NULL,
    history_flag INT UNSIGNED DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (vendor_transaction_id)
    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
    SQL
  end

  def down
    execute "DROP TABLE monetization.vendor_transactions"
  end
end
