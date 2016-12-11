class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
    	t.string :code
    	t.string :amount
    	t.integer :type
    	t.integer :user_id
    	t.timestamps
    end
    add_foreign_key :promo_codes,:users
  end
end
