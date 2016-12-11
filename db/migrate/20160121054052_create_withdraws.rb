class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
    	t.integer :user_id,null: false
    	t.string :amount,null: false
    	t.integer :seller_account_id,null: false
    	t.string :status,null: false,default: 'Active'
    	t.timestamps
    end
    add_foreign_key :withdraws,:seller_accounts
    add_foreign_key :withdraws,:users
  end
end
