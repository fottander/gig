Then(/^I attach file$/) do
  attach_file('profile[avatar]', "#{Rails.root}/spec/images/anewbiz-logo.png", visible: false)
end

Then(/^I should see "([^"]*)" avatar name "([^"]*)"$/) do |profile_username, avatar_name|
  profile = Profile.find_by(username: profile_username)
  within ".profile-#{profile.id}" do
    expect(page).to have_css "img[src*='#{profile.avatar.url}']"
  end
end

Then(/^I should see job "([^"]*)" avatar name "([^"]*)"$/) do |job_title, avatar_name|
  job = Job.find_by(title: job_title)
  job.categories.each do |category|
    within ".job-#{job.id}" do
      expect(page).to have_css "img[src*='#{category.avatar.url}']"
    end
  end
end
