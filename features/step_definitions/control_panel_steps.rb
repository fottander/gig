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

Given("I uncheck Active check box") do
  uncheck 'job_active'
end

Then("I check Terms check box") do
  check 'terms'
end

Then("I uncheck Terms check box") do
  uncheck 'terms'
end

Given("the following invoices exist") do |table|
  table.hashes.each do |hash|
    create(:invoice, hash)
  end
end
