class ChangeColumnInPromoCodes < ActiveRecord::Migration
  def change
  	remove_column :promo_codes,:pctype	
    add_column :promo_codes,:amount_type,:integer
  end
end
