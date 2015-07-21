require "rails_helper"

feature "user views a category" do
  context "multiple venues, one shared category" do
    let (:cafe) { Category.create(name: "Cafe") }
    let (:diner) { Category.create(name: "Diner") }
    let (:venue1) { FactoryGirl.create(:venue, categories: [cafe, diner]) }
    let (:venue2) { FactoryGirl.create(:venue, categories: [diner]) }
    xscenario "from root" do
      visit root_path
      click_link "Cafe"
      expect(page).to have_content venue1.name
      expect(page).to_not have_content venue1.name
    end

    xscenario "from venue page" do
      visit root_path
      click_link venue1.name
      click_link "Diner"
      expect(page).to have_content venue1.name
      expect(page).to have_content venue2.name
    end
  end
end