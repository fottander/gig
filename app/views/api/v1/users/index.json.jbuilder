json.array! @users.each do |user|
  json.id user.id
  json.email user.email
  json.first_name user.first_name
  json.last_name user.last_name
  json.phone user.phone
  json.bank user.bank
  json.clear_nr user.clear_nr
  json.account_nr user.account_nr
  json.created_at user.created_at
  json.updated_at user.updated_at
end