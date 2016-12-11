class ChangeColumnCategoryIntoGigs < ActiveRecord::Migration
  def change
  	remove_column :gigs,:category
  	add_column :gigs,:category_id,:integer
  	add_foreign_key :gigs,:categories
  end
end
