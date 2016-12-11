class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
    	t.integer :gig_id
    	t.integer :user_id
    	t.timestamps
    end
    add_foreign_key :bookmarks,:gigs
    add_foreign_key :bookmarks,:users
  end
end
