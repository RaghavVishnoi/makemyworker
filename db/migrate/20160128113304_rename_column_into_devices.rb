class RenameColumnIntoDevices < ActiveRecord::Migration
  def change
  	rename_column :devices,:token,:installation_id
  end
end
