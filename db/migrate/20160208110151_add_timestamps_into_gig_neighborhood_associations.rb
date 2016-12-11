class AddTimestampsIntoGigNeighborhoodAssociations < ActiveRecord::Migration
  def change
  	add_column :gig_neighborhood_associations,:created_at,:datetime
  	add_column :gig_neighborhood_associations,:updated_at,:datetime
  end
end
