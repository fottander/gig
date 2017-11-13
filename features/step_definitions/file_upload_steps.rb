Then(/^I attach file$/) do
  attach_file('profile[avatar]', "#{Rails.root}/spec/images/Default-avatar.png", visible: false)
end

Then(/^I should see "([^"]*)" avatar name "([^"]*)"$/) do |profile_username, avatar_name|
  profile = Profile.find_by(username: profile_username)
  within ".profile-#{profile.id}" do
    expect(page).to have_css "img[src*='#{profile.avatar.url}']"
  end
end

Then(/^I should see job "([^"]*)" avatar name "([^"]*)"$/) do |job_title, avatar_name|
  job = Job.find_by(title: job_title)
  within ".job-#{job.id}" do
    expect(page).to have_css "img[src*='#{job.avatar.url}']"
  end
end
