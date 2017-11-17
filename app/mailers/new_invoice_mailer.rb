class NewInvoiceMailer < ApplicationMailer
  def notice_email(company, invoice)
    @company = company
    @invoice = invoice

    mail(
    to: @company.email,
    subject: "Ny faktura har skickats till er med id: #{invoice.id}"
    )
  end
end
