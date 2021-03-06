Given("I am on the administrations page") do
  visit administrations_path
end

Given("I am on the admin login page") do
  visit new_admin_session_path
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

Given("I fill in {string} with {string} in city-name") do |field, content|
  within "#city-name" do
    fill_in field, with: content
  end
end

Given("I fill in {string} with {string} in category-name") do |field, content|
  within "#category-name" do
    fill_in field, with: content
  end
end

Given("I click button {string} in {string}") do |button, category_name|
  category = Category.find_by(name: category_name)
  within ".category-#{category.id}" do
    click_link_or_button button
  end
end

Given("I click button {string} in city {string}") do |button, city_name|
  city = City.find_by(name: city_name)
  within ".city-#{city.id}" do
    click_link_or_button button
  end
end

Given("I click link {string} in {string}") do |button, invoice_description|
  invoice = Invoice.find_by(description: invoice_description)
  within ".invoice-#{invoice.id}" do
    click_link_or_button button
  end
end

Given("I click link {string} inside {string}") do |button, ezinvoice_description|
  ezinvoice = Ezinvoice.find_by(description: ezinvoice_description)
  within ".ezinvoice-#{ezinvoice.id}" do
    click_link_or_button button
  end
end
