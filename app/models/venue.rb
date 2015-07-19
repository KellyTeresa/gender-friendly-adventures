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
    "Overall: #{smile_display(reviews.sum(:overall) / reviews.count)}."
  end

  def average_rating_terminology
    ratings = []
    reviews.each do |review|
      unless review.terminology.nil?
        ratings << review.terminology
      end
    end
    if ratings.count > 0
      "Staff terminology: #{smile_display(ratings.sum / ratings.count)}."
    else
      "No data on terminology."
    end
  end

  def average_rating_bathrooms
    ratings = []
    reviews.each do |review|
      unless review.bathrooms.nil?
        ratings << review.bathrooms
      end
    end
    if ratings.count > 0
      "Bathrooms: #{smile_display(ratings.sum / ratings.count)}."
    else
      "No data on bathrooms."
    end
  end

  def smile_display(score)
    if score >= 4.5
      "😍"
    elsif score >= 3.5
      "😃"
    elsif score >= 2.5
      "😐"
    elsif score >= 1.5
      "😔"
    else
      "😡"
    end
  end
end
