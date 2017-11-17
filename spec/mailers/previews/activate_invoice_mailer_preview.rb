# Preview all emails at http://localhost:3000/rails/mailers/activate_invoice_mailer
class ActivateInvoiceMailerPreview < ActionMailer::Preview
  def notice_mail_preview
    ActivateInvoiceMailer.notice_email(User.first, Invoice.first)
  end
end
