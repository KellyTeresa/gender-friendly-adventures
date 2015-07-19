require 'uri'

class Venue < ActiveRecord::Base
  has_many :reviews
  has_many :venue_categories
  has_many :categories, through: :venue_categories
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip_code, presence: true,
    length: { is: 5 }
  validates :summary, presence: true, length: { in: 25..250 }
  validates :description, length: { maximum: 1000 }, allow_nil: true
  validates :website,
    format: { with: URI::regexp(%w(http https)) },
    allow_blank: true

  def full_address
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end
end
