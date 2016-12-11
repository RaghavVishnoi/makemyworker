class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
    	t.integer :request_id,null: false
    	t.string :amount,null: false
    	t.integer :user_id,null: false
    	t.integer :buyer_account_id,null: false
    	t.string :status,null: false,default: 'Active'
    	t.timestamps
    end
    add_foreign_key :charges,:buyer_accounts
    add_foreign_key :charges,:users
    add_foreign_key :charges,:requests
  end
end
