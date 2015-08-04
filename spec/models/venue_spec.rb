require 'rails_helper'

RSpec.describe Venue, type: :model do
  context "a new venue" do
    cafe = {
      name: "A Cool Cafe",
      street_address: "1234 Street Ave.",
      city: "Boston",
      state: "MA",
      zip_code: "02134",
      summary: "A small cafe with a variety of snacks."
    }

    description = "Cupcake ipsum dolor. Sit amet sesame snaps
      jujubes. Cheesecake jelly-o croissant tart chocolate bar.
      Lollipop cake tart gingerbread cake. Jujubes jujubes topping
      tootsie roll macaroon topping chocolate cake. Sweet roll muffin
      tootsie roll tiramisu muffin. Candy canes liquorice danish
      cheesecake pudding cake sweet. Cookie danish pastry. Caramels
      biscuit pie chocolate. Bonbon halvah cake donut cookie caramels
      carrot cake liquorice. Brownie jelly-o cupcake brownie topping
      gummies halvah. Biscuit donut biscuit soufflé.
      Cake macaroon pudding lollipop."

    it "is valid if only required information is provided" do
      venue = Venue.new(
        name: cafe[:name],
        street_address: cafe[:street_address],
        city: cafe[:city],
        state: cafe[:state],
        zip_code: cafe[:zip_code],
        summary: cafe[:summary]
      )
      expect(venue.valid?).to eq true
    end

    it "is valid if optional information is also provided" do
      venue = Venue.new(
        name: cafe[:name],
        street_address: cafe[:street_address],
        city: cafe[:city],
        state: cafe[:state],
        zip_code: cafe[:zip_code],
        summary: cafe[:summary],
        description: description,
        website: "http://www.a-cool-cafe.com",
        phone_number: "617-123-4567"
        )
      expect(venue.valid?).to eq true
    end

    it "is not valid if information is missing" do
      venue = Venue.new(
        name: cafe[:name],
        )
      expect(venue.valid?).to eq false
    end

    it "is not valid if the url is not proper format" do
      venue = Venue.new(
        name: cafe[:name],
        street_address: cafe[:street_address],
        city: cafe[:city],
        state: cafe[:state],
        zip_code: cafe[:zip_code],
        summary: cafe[:summary],
        website: "a-cool-cafe.com"
      )
      expect(venue.valid?).to eq false
    end

    context "is not valid if the summary is wrong length" do
      it "is too long" do
        venue = Venue.new(
          name: cafe[:name],
          street_address: cafe[:street_address],
          city: cafe[:city],
          state: cafe[:state],
          zip_code: cafe[:zip_code],
          summary: description
          )
        expect(venue.valid?).to eq false
      end

      it "is too short" do
        venue = Venue.new(
          name: cafe[:name],
          street_address: cafe[:street_address],
          city: cafe[:city],
          state: cafe[:state],
          zip_code: cafe[:zip_code],
          summary: "A cafe."
          )
        expect(venue.valid?).to eq false
      end
    end

    it "is not valid if the description is too long" do
      venue = Venue.new(
        name: cafe[:name],
        street_address: cafe[:street_address],
        city: cafe[:city],
        state: cafe[:state],
        zip_code: cafe[:zip_code],
        summary: cafe[:summary],
        description: description * 2
      )
      expect(venue.valid?).to eq false
    end
  end

  context "search" do
    it "matches by name" do
      3.times { FactoryGirl.create(:venue) }

      results = Venue.search(Venue.last.name)
      expect(results).to include(Venue.last)
    end

    it "matches by partial name" do
      3.times { FactoryGirl.create(:venue) }

      results = Venue.search(Venue.last.name[0..3])
      expect(results).to include(Venue.last)
    end
  end

  context "display each rating" do
    let(:venue) { FactoryGirl.create(:venue) }
    let!(:reviews) {
      2.times { FactoryGirl.create(:review, venue: venue) }
    }
    it "displays an overall rating as an emoji" do
      expect(venue.overall_average).to eq("Overall: 😐.")
    end

    it "calculates average rating for terminology and displays as an emoji" do
      expect(venue.average_rating(:terminology)).to eq("Terminology: 😐.")
    end

    it "calculates average rating for bathrooms and displays as an emoji" do
      expect(venue.average_rating(:bathrooms)).to eq("Bathrooms: 😐.")
    end
  end

  context "there are not enough ratings" do
    let(:venue) { FactoryGirl.create(:venue) }
    it "has no overall rating" do
      expect(venue.overall_average).to eq(nil)
    end

    it "has no terminology rating" do
      2.times { FactoryGirl.create(:review, venue: venue, terminology: nil) }
      expect(venue.average_rating(:terminology)).to eq("No data on terminology.")
    end

    it "has no bathroom rating" do
      2.times { FactoryGirl.create(:review, venue: venue, bathrooms: nil) }
      expect(venue.average_rating(:bathrooms)).to eq("No data on bathrooms.")
    end
  end

  context "converts numbers 1.0 through 5.0 to emoji for display" do
    let(:venue) { FactoryGirl.create(:venue) }
    it "has an average equal to or more than 4.5" do
      expect(venue.smile_display(4.7)).to eq("😍")
    end

    it "has an average equal to or more than 3.5 and less than 4.5" do
      expect(venue.smile_display(3.7)).to eq("😃")
    end

    it "has an average equal to or more than 2.5 and less than 3.5" do
      expect(venue.smile_display(2.7)).to eq("😐")
    end

    it "has an average equal to or more than 1.5 and less than 2.5" do
      expect(venue.smile_display(1.7)).to eq("😔")
    end

    it "has an average equal to or less than 1.5" do
      expect(venue.smile_display(1)).to eq("😡")
    end
  end
end
