class CreateCitiesWants< ActiveRecord::Migration
  def change
    create_table :cities_wants do |t|
    	t.string  :name, null: false
    	t.integer :user_id, null: false
    	t.timestamps
    end
    add_foreign_key :cities_wants,:users
  end
end
