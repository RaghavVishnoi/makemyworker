class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
    	t.integer :counts
    	t.integer :user_id
    	t.timestamps
    end
    add_foreign_key :credits,:users
  end
end
