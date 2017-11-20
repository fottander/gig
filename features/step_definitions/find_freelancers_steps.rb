Given("the following profiles exist") do |table|
  table.hashes.each do |hash|
    create(:profile, hash)
  end
end

Then("I should see {string} at {string}") do |content, profile_username|
  profile = Profile.find_by(username: profile_username)
  within ".profile-#{profile.id}" do
    expect(page).to have_content content
  end
end
