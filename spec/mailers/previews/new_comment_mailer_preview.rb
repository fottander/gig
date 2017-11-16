# Preview all emails at http://localhost:3000/rails/mailers/new_comment_mailer
class NewCommentMailerPreview < ActionMailer::Preview
  def comment_mail_preview
    NewCommentMailer.comment_email(User.first, Application.first)
  end
end
