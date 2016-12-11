class ChangeBuyerAccount < ActiveRecord::Migration
  def change
    remove_column :buyer_accounts,:card_number
    remove_column :buyer_accounts,:cvc
    remove_column :buyer_accounts,:expiry_month
    remove_column :buyer_accounts,:expiry_year
    add_column    :buyer_accounts,:customer_id,:string	
  end
end
