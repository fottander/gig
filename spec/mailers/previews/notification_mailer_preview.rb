# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def new_invoice_mail_preview
    NotificationMailer.new_invoice_email(Company.first, Invoice.first)
  end
  def hired_mail_preview
    NotificationMailer.hired_email(User.first, Application.first)
  end
  def new_application_mail_preview
    NotificationMailer.new_application_email(Company.first, Job.first)
  end
  def new_comment_mail_preview
    NotificationMailer.new_comment_email(User.first, Application.first, Comment.first)
  end
  def new_user_comment_mail_preview
    NotificationMailer.new_user_comment_email(Company.first, Application.first, Comment.first)
  end
  def extend_mail_preview
    NotificationMailer.extend_email(User.first, Application.first)
  end
  def revert_mail_preview
    NotificationMailer.revert_email(Company.first, Application.first)
  end
  def dehire_mail_preview
    NotificationMailer.dehire_email(User.first, Application.first)
  end
  def clone_mail_preview
    NotificationMailer.clone_email(User.first, Application.first)
  end
  def company_registration_mail_preview
    NotificationMailer.company_registration_email(Company.first)
  end
  def user_registration_mail_preview
    NotificationMailer.user_registration_email(User.first)
  end
end
