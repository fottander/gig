class NewApplicationMailer < ApplicationMailer
  default from: "info@gigalot.se"

  def notice_email(company, job)
    @company = company
    @job = job

    mail(
    to: @company.email,
    subject: "Nytt svar på #{job.title}"
    )
  end
end
