class UpdateColumnToPromoCodes < ActiveRecord::Migration
  def change
  	remove_column :promo_codes,:status
  	add_column :promo_codes,:status,:integer
  end
end
