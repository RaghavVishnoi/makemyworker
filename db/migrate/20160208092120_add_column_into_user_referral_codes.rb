class AddColumnIntoUserReferralCodes < ActiveRecord::Migration
  def change
  	add_column :used_referral_codes,:status,:integer
  end
end
