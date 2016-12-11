class CreateUsedReferralCodes < ActiveRecord::Migration
  def change
    create_table :used_referral_codes do |t|
    	t.integer :referral_code_id, null: false
    	t.integer :user_id, null: false
    	t.timestamps
    end
    add_foreign_key :used_referral_codes,:referral_codes
    add_foreign_key :used_referral_codes,:users
  end
end
