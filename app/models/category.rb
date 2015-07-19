class Category < ActiveRecord::Base
  has_many :venue_categories
  has_many :venues, through: :venue_categories
  validates :name, presence: true, length: { in: 2..20 }
end
