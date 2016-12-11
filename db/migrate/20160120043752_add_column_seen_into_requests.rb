class AddColumnSeenIntoRequests < ActiveRecord::Migration
  def change
  	add_column :requests, :seen, :integer,default: 0
  end
end
