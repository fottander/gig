Then("an invoice with amount {string} is created") do |amount|
  create(:shift, start_date: '2019-01-01', end_date: '2019-01-01', start_time: '10:00', end_time: '20:00', id: 20)
  create(:invoice, shift_ids: 20, user_id: 1, profile_id: 1, company_id: 1, job_id: 1, application_id: 1, description: 'abc', amount: amount, user_reference: 'felix')
end

Then("an invoice with amount {string} and quantity {string} and unit {string} and shiftid {string} is created") do |amount, quantity, unit, shift_id|
  create(:shift, start_date: '2019-01-01', end_date: '2019-01-01', start_time: '10:00', end_time: '20:00', id: shift_id, quantity: quantity)
  create(:invoice, shift_ids: shift_id, user_id: 1, profile_id: 1, company_id: 1, job_id: 1, application_id: 1, description: 'abc', amount: amount, quantity: quantity, unit: unit, user_reference: 'felix')
end

Given("the following ezinvoices exist") do |table|
  table.hashes.each do |hash|
    create(:ezinvoice, hash)
  end
end

Then("I check OB checkbox") do
  check 'add_ob'
end

Given("the following shifts exist") do |table|
  table.hashes.each do |hash|
    create(:shift, hash)
  end
end

Then("the latest created invoice is being paid") do
  invoice = Invoice.first
  invoice.paid = true
  invoice.save
end

Given("the first invoice is being deleted") do
  invoice = Invoice.last
  invoice.destroy
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

Then("I click {string} in active invoices") do |button|
  within "#active-invoices" do
    click_link_or_button button
  end
end

Then("I click {string} terms button") do |button|
  within "#invoice_terms_button" do
    click_link_or_button button
  end
end

Then("I click {string} post button") do |button|
  within "#invoice_post_button" do
    click_link_or_button button
  end
end

Then("the latest created invoice should have ssyk code {string}") do |content|
  invoice = Invoice.first
  expect(invoice.ssyk_code).to have_content content
end

Given("I should see invoice due date") do
  invoice = Invoice.first
  date = (Date.today + 10.days).strftime("%F")
  expect(invoice.due_date.strftime("%F")).to eq date
end

Given("I should see invoice new due date") do
  invoice = Invoice.first
  date = (Date.today + 20.days).strftime("%F")
  expect(invoice.due_date.strftime("%F")).to eq date
end

Given("I fill hidden field amount and fill {string}") do |content|
  find("#amount", visible: false).set content
end

Given("I fill hidden field unit and fill {string}") do |content|
  find(:xpath, "//input[@id='unit-amount']").set content
end

Given("I edit hidden field amount and fill {string}") do |content|
  find("#invoice_amount", visible: false).set content
end

Given("I fill hidden field ez amount and fill {string}") do |content|
  find("#ezinvoice_amount", visible: false).set content
end

Given("I fill in hidden field start day with {string}") do |content|
  find("#first_day", visible: false).set content
end

Given("I fill in hidden field last day with {string}") do |content|
  find("#last_day", visible: false).set content
end

Given("I fill in hidden field salary with {string}") do |content|
  find("#salary", visible: false).set content
end

Then("I fill in startdatum with date {string}") do |content|
  find("#invoice_shifts_attributes_0_start_date").set(content)
end

Then("I fill in starttid with time {string}") do |content|
  find("#invoice_shifts_attributes_0_start_time").set(content)
end

Then("I fill in slutdatum with date {string}") do |content|
  find("#invoice_shifts_attributes_0_end_date").set(content)
end

Then("I fill in sluttid with time {string}") do |content|
  find("#invoice_shifts_attributes_0_end_time").set(content)
end
