require 'rails_helper'

RSpec.describe User, type: :model do
  context "a new user" do
    it "is valid if all information is provided" do
      user = User.new(
        display_name: "user",
        email: "user@example.com",
        password: "password"
        )
      expect(user.valid?).to eq true
    end

    it "is not valid if information is missing" do
      user = User.new(
        display_name: "user",
        password: "password"
        )
      expect(user.valid?).to eq false
    end
  end
end
