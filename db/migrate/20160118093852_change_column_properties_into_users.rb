class ChangeColumnPropertiesIntoUsers < ActiveRecord::Migration
  def change
  	change_column :users, :facebook_user_id, :string, :null => true
  	change_column :users, :facebook_user_token, :string, :null => true
  end
end
