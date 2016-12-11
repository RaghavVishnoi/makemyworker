class AddSeenToMessages < ActiveRecord::Migration
  def change
  	add_column :messages,:seen,:integer
  end
end
