class AddColumnInUsers < ActiveRecord::Migration
  def change
  	add_column :users,:bgcheck_approved,:boolean
  end
end
