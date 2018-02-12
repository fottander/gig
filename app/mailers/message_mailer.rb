class MessageMailer < ApplicationMailer
  # use your own email address here
  default to: 'info@anewbiz.se'
  default sender: 'info@anewbiz.se'
  default subject: 'Support'
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@anewbiz.se>"

  def message_me(msg)
    @msg = msg

    mail(from: @msg.email, name: @msg.name, phone_number: @msg.phone_number, body: @msg.body)
  end
end
