require 'digest/sha2'
class MessageMailer < ApplicationMailer
  # use your own email address here
  default from: 'info@anewbiz.se'
  default subject: 'Support'
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@anewbiz.se>"

  def message_me(msg)
    @msg = msg
    @body = msg.body
    mail(to: @msg.email, name: @msg.name, phone_number: @msg.phone_number)
  end
end
