require 'digest/sha2'
class ApplicationMailer < ActionMailer::Base
  default from: 'info@anewbiz.se'
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@anewbiz.se>"
  layout 'mailer'
end
