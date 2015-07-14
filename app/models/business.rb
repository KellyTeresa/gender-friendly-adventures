require 'uri'

class Business < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :summary, presence: true, length: { in: 25..250 }
  validates :description, length: { maximum: 1000 }, allow_nil: true
  validates :website, format: { with: URI::regexp(%w(http https)) },
    allow_nil: true
end
