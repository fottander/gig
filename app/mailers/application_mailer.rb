require 'digest/sha2'
class ApplicationMailer < ActionMailer::Base
  default from: 'info@joboy.se'
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@joboy.se>"
end
