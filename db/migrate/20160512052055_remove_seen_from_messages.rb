class RemoveSeenFromMessages < ActiveRecord::Migration
  def change
  	remove_column :messages,:seen
  end
end
