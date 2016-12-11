class Image < ActiveRecord::Base

	mount_uploader :image, ImageUploader	
	validates :image, presence: true
	validate :imageable_id
	validate :imageable_type

end
