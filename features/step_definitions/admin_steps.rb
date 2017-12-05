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

Given("I click button {string} in {string}") do |button, category_name|
  category = Category.find_by(name: category_name)
  within ".category-#{category.id}" do
    click_link_or_button button
  end
end

Given("I click link {string} in {string}") do |button, invoice_description|
  invoice = Invoice.find_by(description: invoice_description)
  within ".invoice-#{invoice.id}" do
    click_link_or_button button
  end
end
