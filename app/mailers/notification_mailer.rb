class NotificationMailer < ApplicationMailer
  default from: "felix.ottander@gmail.com"

  def activate_invoice_email(user, invoice)
    @user = user
    @invoice = invoice

    mail(
    to: @user.email,
    subject: "Din faktura med id: #{invoice.id} har blivit godkänd"
    )
  end

  def new_invoice_email(company, invoice)
    @company = company
    @invoice = invoice

    mail(
    to: @company.email,
    subject: "Ny faktura har skickats till er med id: #{invoice.id}"
    )
  end

  def job_invite_email(user, invite)
    @user = user
    @invite = invite

    mail(
    to: @user.email,
    subject: "Ny inbjudan har skickats till er"
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
  def job_completed_email(user, application)
    @user = user
    @application = application

    mail(
    to: @user.email,
    subject: "Ditt jobb har blivit godkänt"
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
