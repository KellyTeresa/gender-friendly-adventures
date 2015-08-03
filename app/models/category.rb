class Category < ActiveRecord::Base
  has_many :venue_categories
  has_many :venues, through: :venue_categories
  validates :name, presence: true, length: { in: 2..20 }

  def approved_venues?
    if venues.count == 0 || venues.count == nil
      false
    else
      count_approvals
    end
  end

  def count_approvals
    approval = []
    venues.each do |venue|
      approval << venue if venue.approved == true
    end
    if approval.count >= 1
      true
    else
      false
    end
  end

end
