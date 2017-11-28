json.array! @companies.each do |company|
  json.id company.id
  json.email company.email
  json.name company.name
  json.username company.username
  json.address company.address
  json.zip_code company.zip_code
  json.city company.city
  json.org_number company.org_number
  json.phone company.phone
  json.contact company.contact
  json.invoice_address company.invoice_address
  json.created_at company.created_at
  json.updated_at company.updated_at
end