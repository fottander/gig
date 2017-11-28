json.array! @profiles.each do |profile|
  json.id profile.id
  json.username profile.username
  json.title profile.title
  json.description profile.description
  json.skill profile.skill
  json.rate profile.rate
  json.city profile.city
  json.created_at profile.created_at
  json.updated_at profile.updated_at
  json.user_id profile.user_id
  json.category_ids profile.category_ids
end
