class VenueCategory < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
end
