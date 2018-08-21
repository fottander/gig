Given(/^I am on the home page$/) do
  visit root_path
end

Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

Given("I am on the profiles_path") do
  visit profiles_path
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

Given("I click {string} within freelancer") do |link|
  within ".marketing-freelancer" do
    click_link_or_button link
  end
end

Given("I click {string} within company") do |link|
  within ".marketing-company" do
    click_link_or_button link
  end
end

Then("I should see {string} within freelancer") do |content|
  within ".marketing-freelancer" do
    expect(page).to have_content content
  end
end

Then("I should see {string} within company") do |content|
  within ".marketing-company" do
    expect(page).to have_content content
  end
end

Then("I click {string} in left menu") do |link|
  within ".holy-grail-left-application" do
    click_link_or_button link
  end
end

Then("I click {string} in classic") do |link|
  within ".classic" do
    click_link_or_button link
  end
end

Then("I click {string} in language") do |link|
  within ".language" do
    click_link_or_button link
  end
end

Then("I click {string} in license") do |link|
  within ".license" do
    click_link_or_button link
  end
end

Then("I click {string} in education") do |link|
  within ".education" do
    click_link_or_button link
  end
end

Then("I click {string} in prev-work") do |link|
  within ".prev-work" do
    click_link_or_button link
  end
end

Then("I click {string} in skill") do |link|
  within ".skill" do
    click_link_or_button link
  end
end

Given("I click hidden button with id {string}") do |button_id|
  find("##{button_id}", visible: false).click
end
