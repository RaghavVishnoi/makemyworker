class CreateBuyerAccounts < ActiveRecord::Migration
  def change
    create_table :buyer_accounts do |t|
    	t.string :card_number,null: false
    	t.integer :cvc,null: false
    	t.string :expiry_date,null: false
    	t.integer :user_id,null: false
    	t.string :status,null: false,default: 'Active'
    	t.timestamps
    end
    add_foreign_key :buyer_accounts,:users
  end
end
