class NotificationMailer < ApplicationMailer
  default from: "info@anewbiz.se"

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

  def extend_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Din anställning har blivit förlängd"
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

    mail(
    to: @user.email,
    subject: "Nytt svar på ansökan nr: #{application.id}"
    )
  end
end
