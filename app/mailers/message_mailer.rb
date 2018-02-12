class MessageMailer < ApplicationMailer
  require 'mailgun'

  def message_me(msg)
    @msg = msg
    mg_client = Mailgun::Client.new ENV['mailgun_api']
    message_params = {from: @msg.email,
                      to: 'info@anewbiz.se',
                      sender: 'info@anewbiz.se',
                      subject: 'Support',
                      message_id: "<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@anewbiz.se>",
                      name: @msg.name,
                      phone_number: @msg.phone_number,
                      text: @msg.body}
    mg_client.send_message ENV['domain'], message_params
  end
end
