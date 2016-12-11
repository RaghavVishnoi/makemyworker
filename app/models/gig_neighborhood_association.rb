class GigNeighborhoodAssociation < ActiveRecord::Base
	belongs_to :gigs
	belongs_to :neighborhoods
end