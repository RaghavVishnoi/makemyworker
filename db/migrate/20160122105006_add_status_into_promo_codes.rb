class AddStatusIntoPromoCodes < ActiveRecord::Migration
  def change
  	add_column :promo_codes,:status,:string
  end
end
