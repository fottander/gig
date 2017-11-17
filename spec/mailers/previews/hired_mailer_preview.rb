# Preview all emails at http://localhost:3000/rails/mailers/hired_mailer
class HiredMailerPreview < ActionMailer::Preview
  def notification_mail_preview
    HiredMailer.notification_email(User.first, Application.first)
  end
end
