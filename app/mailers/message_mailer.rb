require 'digest/sha2'
class MessageMailer < ApplicationMailer
  default to: "Qnekt <info@qnekt.se>"
  default subject: 'Qnekt support'
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@qnekt.se>"

  def message_me(msg)
    @msg = msg
    @body = msg.content
    mail(from: @msg.email, name: @msg.name, phone_number: @msg.phone_number)
  end
end
