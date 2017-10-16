Given(/^I am on the home page$/) do
  visit root_path
end

Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

Given("I click {string}") do |button|
  click_link_or_button button
end

Given(/^I am logged in as company "([^"]*)"$/) do |email|
  company = Company.find_by(email: email)
  login_as(company, scope: :company)
end

Given("I am logged in as user {string}") do |email|
  user = User.find_by(email: email)
  login_as(user, scope: :user)
end

Given("I am on the dashboards page") do
  visit dashboards_path
end
