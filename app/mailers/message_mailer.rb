class MessageMailer < ApplicationMailer
  # use your own email address here
  default :to => "felix@ottander.se"

  def message_me(msg)
    @msg = msg

    mail(from: @msg.email, name: @msg.name, phone_number: @msg.phone_number, body: @msg.body)
  end
end
