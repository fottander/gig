json.array! @invoices.each do |invoice|
  json.id invoice.id
  json.quantity invoice.quantity
  json.unit invoice.unit
  json.amount invoice.amount
  json.first_day invoice.first_day
  json.last_day invoice.last_day
  json.description invoice.description
  json.user_reference invoice.user_reference
  json.company_reference invoice.company_reference
  json.terms invoice.terms
  json.paid invoice.paid
  json.active invoice.active
  json.user_id invoice.user_id
  json.company_id invoice.company_id
  json.application_id invoice.application_id
  json.job_id invoice.job_id
  json.profile_id invoice.profile_id
  json.profile_username invoice.profile_username
  json.post invoice.post
  json.feedback invoice.feedback
  json.created_at invoice.created_at
  json.updated_at invoice.updated_at
end
