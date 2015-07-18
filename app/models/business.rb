require 'uri'

class Business < ActiveRecord::Base
  has_many :reviews
  has_many :business_categories
  has_many :categories, through: :business_categories
  validates :name, presence: true
  validates :address, presence: true
  validates :summary, presence: true, length: { in: 25..250 }
  validates :description, length: { maximum: 1000 }, allow_nil: true
  validates :website,
    format: { with: URI::regexp(%w(http https)) },
    allow_blank: true
end
