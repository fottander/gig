Given("I fill in {string} with {string}") do |field, content|
  fill_in field, with: content
end

Given("the following users exist") do |table|
  table.hashes.each do |hash|
    create(:user, hash)
  end
end

Given("the following companies exist") do |table|
  table.hashes.each do |hash|
    create(:company, hash)
  end
end

Then("the last created user is marked confirmed") do
  u = User.first
  u.confirm
  u.save
end
