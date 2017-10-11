Given("the following job ads exist") do |table|
  table.hashes.each do |hash|
    create(:job, hash)
  end
end
