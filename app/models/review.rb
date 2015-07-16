class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  validates :comment, presence: true, length: { in: 25..500 }
end
