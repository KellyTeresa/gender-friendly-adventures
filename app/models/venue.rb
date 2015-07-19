require "uri"

class Venue < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :venue_categories
  has_many :categories, through: :venue_categories
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip_code, presence: true, length: { is: 5 }
  validates :summary, presence: true, length: { in: 25..250 }
  validates :description, length: { maximum: 1000 }, allow_nil: true
  validates :website,
    format: { with: URI::regexp(%w(http https)) },
    allow_blank: true

  def full_address
    "#{street_address}, #{city}, #{state}, #{zip_code}."
  end

  def overall_average
    reviews.sum(:overall) / reviews.count
  end

  def average_rating_terminology
    ratings = []
    reviews.each do |review|
      unless review.terminology.nil?
        ratings << review.terminology
      end
    end
    ratings.sum / ratings.count
  end

  def average_rating_bathrooms
    ratings = []
    reviews.each do |review|
      unless review.bathrooms.nil?
        ratings << review.bathrooms
      end
    end
    ratings.sum / ratings.count
  end
end
