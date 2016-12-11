class ChangeSellerAccount < ActiveRecord::Migration
  def change
    remove_column :seller_accounts,:country
    remove_column :seller_accounts,:routing_number
    remove_column :seller_accounts,:account_number
    add_column :seller_accounts,:recipient_id,:string	
  end
end
