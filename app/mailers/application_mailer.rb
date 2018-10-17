require 'digest/sha2'
class ApplicationMailer < ActionMailer::Base
  default from: "Qnekt info <info@qnekt.se>"
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@qnekt.se>"
  layout 'mailer'
end
