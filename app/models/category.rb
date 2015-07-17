class Category < ActiveRecord::Base
  has_many :businesses_categories
  has_many :businesses, through: :businesses_categories
  validates :name, presence: true, length: { in: 2..20 }
end
