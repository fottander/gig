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

Given("the following invoices exist") do |table|
  table.hashes.each do |hash|
    create(:invoice, hash)
  end
end

Then("invoice is sending by post") do
  invoice = Invoice.first
  expect(invoice.post).to be true
end
