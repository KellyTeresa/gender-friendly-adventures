class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  validates :body, presence: true, length: { in: 25..500 }
end
