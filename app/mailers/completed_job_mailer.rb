class CompletedJobMailer < ApplicationMailer
  default from: "info@gigalot.se"

  def notification_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Ditt jobb har blivit godkänt"
    )
  end
end
