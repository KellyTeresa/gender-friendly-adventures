require "uri"

class Venue < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :venue_categories
  has_many :categories, through: :venue_categories
  accepts_nested_attributes_for :categories

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
  validates :approved, inclusion: { in: [true, false] }

  include PgSearch
  pg_search_scope :search,
    against: [
      :name, :street_address, :city, :state, :zip_code, :summary, :description
    ],
    using: {
      tsearch: { prefix: true }
    }

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    "#{street_address}, #{city}, #{state}, #{zip_code}."
  end

  def overall_average
    "Overall: #{smile_display(reviews.sum(:overall) / reviews.count)}."
  end

  def average_rating(kind_of_review)
    ratings = []
    reviews.each do |review|
      ratings << review.try(kind_of_review)
    end
    ratings.reject!(&:nil?)
    if ratings.count > 0
      "#{kind_of_review.capitalize}: #{smile_display(
        ratings.sum / ratings.count)}."
    else
      "No data on #{kind_of_review}."
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
