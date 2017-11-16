# Preview all emails at http://localhost:3000/rails/mailers/new_application_mailer
class NewApplicationMailerPreview < ActionMailer::Preview
  def notice_mail_preview
    NewApplicationMailer.notice_email(Company.first, Job.first)
  end
end
