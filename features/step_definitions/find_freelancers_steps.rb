Given("the following profiles exist") do |table|
  table.hashes.each do |hash|
    create(:profile, hash)
  end
end
