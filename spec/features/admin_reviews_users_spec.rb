feature "admin reviews users" do
  xscenario "view users" do
    users = []
    3.times do
      users << FactoryGirl.create(:user)
    end
    visit admin_dashboard_path
  end
end
