Given("I fill in {string} with {string}") do |field, content|
  fill_in field, with: content
end

Given("I fill hidden field amount and fill {string}") do |content|
  find("#amount", visible: false).set content
end

Given("I edit hidden field amount and fill {string}") do |content|
  find("#invoice_amount", visible: false).set content
end

Given("I fill hidden field ez amount and fill {string}") do |content|
  find("#ezinvoice_amount", visible: false).set content
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
