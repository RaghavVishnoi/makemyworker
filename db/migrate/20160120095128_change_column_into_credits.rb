class ChangeColumnIntoCredits < ActiveRecord::Migration
  def change
  	change_column :credits, :counts, :string
  end
end
