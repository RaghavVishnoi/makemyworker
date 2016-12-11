class ChangeColumnIntoBuyerAccounts < ActiveRecord::Migration
  def change
  	remove_column :buyer_accounts,:expiry_date
  	add_column :buyer_accounts,:expiry_month,:integer
  	add_column :buyer_accounts,:expiry_year,:integer
  end
end
