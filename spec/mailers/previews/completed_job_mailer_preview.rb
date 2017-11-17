# Preview all emails at http://localhost:3000/rails/mailers/completed_job_mailer
class CompletedJobMailerPreview < ActionMailer::Preview
  def notification_mail_preview
    CompletedJobMailer.notification_email(User.first, Application.first)
  end
end
