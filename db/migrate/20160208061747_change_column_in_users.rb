class ChangeColumnInUsers < ActiveRecord::Migration
  def change
  	change_column :users,:bgcheck_approved,:boolean,default: false
  end
end
