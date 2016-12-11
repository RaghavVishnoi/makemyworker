class UpdateColumnIntoMyPromoCodes < ActiveRecord::Migration
  def change
  	add_column :my_promo_codes,:code,:string
  end
end
