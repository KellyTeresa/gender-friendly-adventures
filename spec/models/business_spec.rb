require 'rails_helper'

RSpec.describe Business, type: :model do
  context "a new business" do
    let (:cafe) { {
        name: "A Cool Cafe",
        address: "1234 Street Ave. Boston, MA",
        summary: "A small cafe with a variety of snacks."
      }
    }

    let (:description) {
      "Cupcake ipsum dolor. Sit amet sesame snaps
      jujubes. Cheesecake jelly-o croissant tart chocolate bar.
      Lollipop cake tart gingerbread cake. Jujubes jujubes topping
      tootsie roll macaroon topping chocolate cake. Sweet roll muffin
      tootsie roll tiramisu muffin. Candy canes liquorice danish
      cheesecake pudding cake sweet. Cookie danish pastry. Caramels
      biscuit pie chocolate. Bonbon halvah cake donut cookie caramels
      carrot cake liquorice. Brownie jelly-o cupcake brownie topping
      gummies halvah. Biscuit donut biscuit soufflé.
      Cake macaroon pudding lollipop."
    }

    it "is valid if only required information is provided" do
      business = Business.new(
        name: cafe[:name],
        address: cafe[:address],
        summary: cafe[:summary]
      )
      expect(business.valid?).to eq true
    end

    it "is valid if optional information is also provided" do
      business = Business.new(
        name: cafe[:name],
        address: cafe[:address],
        summary: cafe[:summary],
        description: description,
        website: "http://www.a-cool-cafe.com",
        phone_number: "617-123-4567"
        )
      expect(business.valid?).to eq true
    end

    it "is not valid if information is missing" do
      business = Business.new(
        name: cafe[:name],
        )
      expect(business.valid?).to eq false
    end

    it "is not valid if the url is not proper format" do
      business = Business.new(
        name: cafe[:name],
        address: cafe[:address],
        summary: cafe[:summary],
        website: "a-cool-cafe.com"
      )
      expect(business.valid?).to eq false
    end

    context "is not valid if the summary is wrong length" do
      it "is too long" do
        business = Business.new(
          name: cafe[:name],
          address: cafe[:address],
          summary: description
          )
        expect(business.valid?).to eq false
      end

      it "is too short" do
        business = Business.new(
          name: cafe[:name],
          address: cafe[:address],
          summary: "A cafe."
          )
        expect(business.valid?).to eq false
      end
    end

    it "is not valid if the description is too long" do
      business = Business.new(
        name: cafe[:name],
        address: cafe[:address],
        summary: cafe[:summary],
        description: description * 2
      )
      expect(business.valid?).to eq false
    end
  end
end
