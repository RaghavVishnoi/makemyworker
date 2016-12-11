class UpdateTablePromoCodes < ActiveRecord::Migration
  def change
  	add_column :promo_codes,:all_users,:boolean
  	add_column :promo_codes,:expire_on,:datetime
  end
end
