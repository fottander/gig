Given(/^I am on the home page$/) do
  visit root_path
end

Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

Given("I click {string}") do |button|
  click_link_or_button button
end

Given("I am logged in as user {string}") do |email|
  user = User.find_by(email: email)
  login_as(user, scope: :user)
end

Given("I am on the dashboards page") do
  visit dashboards_path
end

Then(/^I select "([^"]*)" from "([^"]*)"$/) do |option, choices|
  select option, from: choices
end

Then(/^show me the page$/) do
 save_and_open_page
end

Given("I click {string} within section") do |link|
  within ".marketing-site-content-section" do
    click_link_or_button link
  end
end

Given("I click {string} within hero") do |link|
  within ".marketing-site-hero-content" do
    click_link_or_button link
  end
end
