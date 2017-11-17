# Preview all emails at http://localhost:3000/rails/mailers/new_invoice_mailer
class NewInvoiceMailerPreview < ActionMailer::Preview
  def notice_mail_preview
    NewInvoiceMailer.notice_email(Company.first, Invoice.first)
  end
end
