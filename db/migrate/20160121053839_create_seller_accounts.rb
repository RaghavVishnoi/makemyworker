class CreateSellerAccounts < ActiveRecord::Migration
  def change
    create_table :seller_accounts do |t|
    	t.string :country,null: false
    	t.integer :routing_number,null: false
    	t.string :account_number,null: false
    	t.integer :user_id,null: false
    	t.string :status,null: false,default: 'Active'
    	t.timestamps
    end
    add_foreign_key :seller_accounts,:users
  end
end
