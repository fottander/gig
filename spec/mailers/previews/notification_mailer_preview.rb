# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def activate_invoice_mail_preview
    NotificationMailer.activate_invoice_email(User.first, Invoice.first)
  end
  def new_invoice_mail_preview
    NotificationMailer.new_invoice_email(Company.first, Invoice.first)
  end
  def hired_mail_preview
    NotificationMailer.hired_email(User.first, Application.first)
  end
  def job_completed_mail_preview
    NotificationMailer.job_completed_email(User.first, Application.first)
  end
  def new_application_mail_preview
    NotificationMailer.new_application_email(Company.first, Job.first)
  end
  def new_comment_mail_preview
    NotificationMailer.new_comment_email(User.first, Application.first)
  end
end