class Venue < ActiveRecord::Base

	has_many :gigs

	validates :name, presence: true
	validates :address, presence: true
	validate  :main_picture_url
	validate  :thumbnail_picture_url
	validates :location_id, presence: true
	validates :category_names, presence: true
	validates :lat, presence: true
	validates :lng, presence: true
	validates :token, presence: true
	validates :status, presence: true

end