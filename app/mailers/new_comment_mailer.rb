class NewCommentMailer < ApplicationMailer
  default from: "info@gigalot.se"

  def comment_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Nytt svar på ansökan nr: #{application.id}"
    )
  end
end
