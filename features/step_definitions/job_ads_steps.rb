Given("the following job ads exist") do |table|
  table.hashes.each do |hash|
    create(:job, hash)
  end
end

Given("the following categories exist") do |table|
  table.hashes.each do |hash|
    create(:category, hash)
  end
end

Then("I should not see {string}") do |content|
  expect(page).not_to have_content content
end

Given("I am on the jobs page") do
  visit jobs_path
end

Given("the following cities exist") do |table|
  table.hashes.each do |hash|
    create(:city, hash)
  end
end
