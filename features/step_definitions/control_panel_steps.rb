Given("I am on control panel page") do
  visit panels_path
end

Given(/^I am logged in as company "([^"]*)"$/) do |email|
  company = Company.find_by(email: email)
  login_as(company, scope: :company)
end

Given("the following applications exist") do |table|
  table.hashes.each do |hash|
    create(:application, hash)
  end
end
