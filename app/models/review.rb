class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  validates :comment, presence: true, length: { in: 25..500 }
  validates :overall, presence: true, numericality: { only_integer: true }

  def self.terminology_options
    {
      "Constantly" => 1,
      "Frequently" => 2,
      "Occasionaly" => 3,
      "Rarely" => 4,
      "Never, yay!" => 5
    }
  end

  def self.bathroom_options
    {
      "Gender based multi-stall horror." => 1,
      "Gender based single stall, requires key/code from staff." => 2,
      "Gender based single stall, no key/code required." => 3,
      "Gender neutral available, but specifically
        for family and/or accessible use only." => 4,
      "Gender neutral bathrooms all around, yay!" => 5
    }
  end
end
