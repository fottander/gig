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

Then("I should see {string} beside {string}") do |content, job_id|
  job = Job.find_by(id: job_id)
  within ".job-#{job.id}" do
    expect(page).to have_content content
  end
end

Then("I should not see {string} beside {string}") do |content, job_id|
  job = Job.find_by(id: job_id)
  within ".job-#{job.id}" do
    expect(page).not_to have_content content
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

Then("invoice is sending by post") do
  invoice = Invoice.first
  expect(invoice.post).to be true
end

Given("I should see {string} jobs description {string}") do |job_id, job_description|
  job = Job.find_by(id: job_id)
  within ".job-#{job.id}" do
    expect(page).to have_content job_description
  end
end

Given("I click job {string} button {string}") do |job_id, button|
  job = Job.find_by(id: job_id)
  within ".job-#{job.id}" do
    click_link_or_button button
  end
end
