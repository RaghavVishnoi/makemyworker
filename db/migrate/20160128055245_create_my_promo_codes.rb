class CreateMyPromoCodes < ActiveRecord::Migration
  def change
    create_table :my_promo_codes do |t|
    	t.integer  :promo_code_id,null: false
    	t.integer  :user_id,null: false
    	t.datetime :added_on,null: false
    	t.integer  :status,null: false 
    	t.timestamps
    end
    add_foreign_key :my_promo_codes,:promo_codes
    add_foreign_key :my_promo_codes,:users
  end
end
