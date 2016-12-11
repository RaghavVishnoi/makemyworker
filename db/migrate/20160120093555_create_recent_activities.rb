class CreateRecentActivities < ActiveRecord::Migration
  def change
    create_table :recent_activities do |t|
    	t.string :messages
    	t.integer :user_id
    	t.timestamps
    end
    add_foreign_key :recent_activities,:users
  end
end
