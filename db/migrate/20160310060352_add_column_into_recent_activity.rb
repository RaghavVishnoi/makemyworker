class AddColumnIntoRecentActivity < ActiveRecord::Migration
  def change
  	add_column :recent_activities,:sender_id,:integer
  end
end
