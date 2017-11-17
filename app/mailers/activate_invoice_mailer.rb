class ActivateInvoiceMailer < ApplicationMailer
  default from: "info@gigalot.se"

  def notice_email(user, invoice)
    @user = user
    @invoice = invoice

    mail(
    to: @user.email,
    subject: "Din faktura med id: #{invoice.id} har blivit godkänd"
    )
  end
end
