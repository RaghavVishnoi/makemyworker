class AddColumnIntoMyPromoCodes < ActiveRecord::Migration
  def change
  	add_column :my_promo_codes,:is_referral_code,:boolean,default: false
  end
end
