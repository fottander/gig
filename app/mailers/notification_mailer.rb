class NotificationMailer < ApplicationMailer
  require 'mailgun'
  default from: "info@joboy.se"

  def activate_invoice_email(user, invoice)
    @user = user
    @invoice = invoice

    mail(
    to: @user.email,
    subject: "Din faktura med ocr nummer: #{invoice.ocr_number} har blivit godkänd"
    )
  end

  def new_invoice_email(company, invoice)
    @company = company
    @invoice = invoice

    mail(
    to: @company.email,
    subject: "Ny faktura har skickats till er med ocr nummer: #{invoice.ocr_number}"
    )
  end

  def hired_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Du har blivit anställd. Grattis!"
    )
  end

  def new_application_email(company, job)
    @company = company
    @job = job

    mail(
    to: @company.email,
    subject: "Nytt svar på #{job.title}"
    )
  end

  def new_comment_email(user, application)
    @user = user
    @application = application
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from => 'info@joboy.se',
                      :to => @user.email,
                      :subject => "Nytt svar på ansökan nr: #{application.id}",
                      :html => (render_to_string(template: "../views/layouts/mailer")).to_str }
    mg_client.send_message ENV['domain'], message_params
  end
end
