class Device < ActiveRecord::Base

  belongs_to :user

  validates :installation_id,presence: true
  validates :user_id,presence: true
  validates :device_type,presence: true

 

end