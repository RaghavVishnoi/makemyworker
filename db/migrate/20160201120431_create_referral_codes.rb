class CreateReferralCodes < ActiveRecord::Migration
  def change
    create_table :referral_codes do |t|
    	t.string  :code,null: false
    	t.integer :user_id,null: false
    	t.timestamps
    end
    add_foreign_key :referral_codes,:users
  end
end
