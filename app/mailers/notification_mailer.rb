class NotificationMailer < ApplicationMailer
  default from: "info@anewbiz.se"

  def new_invoice_email(company, invoice)
    @company = company
    @invoice = invoice

    mail(
    to: @company.email,
    subject: "Ny faktura har skickats till er med ocr nummer: #{invoice.ocr_number}"
    )
  end

  def company_registration_email(company)
    @company = company

    mail(
    to: @company.email,
    subject: "Välkommen till A New Biz"
    )
  end

  def user_registration_email(user)
    @user = user

    mail(
    to: @user.email,
    subject: "Välkommen till A New Biz"
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

  def clone_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Du har blivit anställd igen"
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
