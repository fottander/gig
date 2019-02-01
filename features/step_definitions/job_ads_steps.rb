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

Then("I get hired") do
  application = Application.last
  application.hired = true
  application.save
end

Given("I should see {string} in active jobs") do |content|
  within "#active_jobs" do
    expect(page).to have_content content
  end
end

Then("I should see {string} in not active applications") do |content|
  within "#not_active_applications" do
    expect(page).to have_content content
  end
end

Then("I should see {string} in active applications") do |content|
  within "#active-applications" do
    expect(page).to have_content content
  end
end

Then("I should see {string} in active employments") do |content|
  within "#active-employments" do
    expect(page).to have_content content
  end
end

Then("I should not see {string} in active employments") do |content|
  within "#active-employments" do
    expect(page).not_to have_content content
  end
end

Then("I should see {string} in complete employments") do |content|
  within "#complete-employments" do
    expect(page).to have_content content
  end
end

Then("I should not see {string} in complete employments") do |content|
  within "#complete-employments" do
    expect(page).not_to have_content content
  end
end

Then("I should not see {string} in active applications") do |content|
  within "#active-applications" do
    expect(page).not_to have_content content
  end
end

Then("I should see {string} in done applications") do |content|
  within "#done-applications" do
    expect(page).to have_content content
  end
end

Then("I should see {string} in active invoices") do |content|
  within "#active-invoices" do
    expect(page).to have_content content
  end
end

Then("I should see deadline two years ahead") do
  job = Job.first
  date = (Date.today + 730.days).strftime("%F")
  expect(job.deadline.strftime("%F")).to eq date
end
