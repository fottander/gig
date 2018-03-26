Then("an invoice with amount {string} is created and activated") do |amount|
  create(:invoice, user_id: 1, profile_id: 1, company_id: 1, job_id: 1, application_id: 1, active: true, description: 'abc', amount: amount, user_reference: 'felix')
end

Given("the following ezinvoices exist") do |table|
  table.hashes.each do |hash|
    create(:ezinvoice, hash)
  end
end

Then("the latest created invoice is beeing activated") do
  invoice = Invoice.first
  invoice.active = true
  invoice.save
end

Then("the latest created ezinvoice is beeing activated") do
  ezinvoice = Ezinvoice.first
  ezinvoice.active = true
  ezinvoice.save
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

Then("the latest created invoice should have ssyk code {string}") do |content|
  invoice = Invoice.first
  expect(invoice.ssyk_code).to have_content content
end
