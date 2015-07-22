feature "admin reviews pending venues" do
  before(:each) do
    3.times do
      FactoryGirl.create(:venue)
    end
  end

  xscenario "view pending venues" do
    visit admin_dashboard_path
    click_link "Pending Venues"
    expect(current_path).to eq(admin_venues_path)
    expect(current_path)
  end

  xscenario "approve venue" do
  end
end
