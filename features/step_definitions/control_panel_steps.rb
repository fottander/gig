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

Given("the following invites exist") do |table|
  table.hashes.each do |hash|
    create(:invite, hash)
  end
end

Given("I uncheck Active check box") do
  uncheck 'job_active'
end

Then("I check Terms check box") do
  check 'terms'
end

Given("I check Category check box") do
  check 'profile_category_ids_1'
end

Then("I uncheck Terms check box") do
  uncheck 'terms'
end

Then("I check Post check box") do
  check 'post'
end

Then("I uncheck Post check box") do
  uncheck 'post'
end

Given("the following invoices exist") do |table|
  table.hashes.each do |hash|
    create(:invoice, hash)
  end
end

Then("invoice {string} is sending by post") do |id|
  invoice = Invoice.find_by(id: id)
  expect(invoice.post).to be true
end
