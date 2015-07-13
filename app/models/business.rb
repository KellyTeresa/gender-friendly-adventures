class Business < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :summay, presence: true, length: { in: 50..250 }
  validates :description, length: { maximum: 1000 }, allow_nil: true
end
