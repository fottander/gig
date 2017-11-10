Then(/^I attach file$/) do
  attach_file('news[file]', "#{Rails.root}/spec/images/Default-avatar.png", visible: false)
end

Then(/^I should see "([^"]*)" avatar name "([^"]*)"$/) do |news_title, file_name|
  news = News.find_by(title: news_title)
  within '#news' do
    within ".news-#{news.id}" do
      expect(page).to have_css "img[src*='#{news.file.url}']"
    end
  end
end
