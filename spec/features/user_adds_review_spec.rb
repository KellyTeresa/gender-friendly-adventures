require "rails_helper"

feature "add a review" do
  let (:venue) { FactoryGirl.create(:business) }
  let (:user) { FactoryGirl.create(:user) }
  let (:review) { FactoryGirl.build(:review) }
  xscenario "user adds a review with minimum required fields" do

  end

  xscenario "user adds a review including optional fields" do

  end

  xscenario "user attempts to add review with missing fields" do

  end
end
