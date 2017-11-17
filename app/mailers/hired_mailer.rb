class HiredMailer < ApplicationMailer
  default from: "info@gigalot.se"

  def notification_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Du har blivit anställd. Grattis!"
    )
  end
end
