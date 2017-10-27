Given("the following job ads exist") do |table|
  table.hashes.each do |hash|
    create(:job, hash)
  end
end

Then("I should not see {string}") do |content|
  expect(page).not_to have_content content
end
