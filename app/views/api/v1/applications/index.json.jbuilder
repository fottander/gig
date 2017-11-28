json.array! @applications.each do |application|
  json.id application.id
  json.message application.message
  json.hired application.hired
  json.complete application.complete
  json.job_id application.job_id
  json.profile_id application.profile_id
  json.profile_username application.profile_username
  json.job_title application.job_title
  json.created_at application.created_at
  json.updated_at application.updated_at
end
