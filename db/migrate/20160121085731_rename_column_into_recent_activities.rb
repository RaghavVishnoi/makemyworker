class RenameColumnIntoRecentActivities < ActiveRecord::Migration
  def change
  	rename_column :recent_activities,:messages,:message
  end
end
