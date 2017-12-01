Given("I am on the administrations page") do
  visit administrations_path
end

Given("I am logged in as admin {string}") do |email|
  admin = Admin.find_by(email: email)
  login_as(admin, scope: :admin)
end

Given("the following admins exist") do |table|
  table.hashes.each do |hash|
    create(:admin, hash)
  end
end
