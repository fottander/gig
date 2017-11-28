json.array! @jobs.each do |job|
  json.id job.id
  json.title job.title
  json.description job.description
  json.category job.category
  json.city job.city
  json.budget job.budget
  json.deadline job.deadline
  json.duration job.duration
  json.hour_week job.hour_week
  json.requirement job.requirement
  json.active job.active
  json.company_id job.company_id
  json.company_city job.company_city
  json.created_at job.created_at
  json.updated_at job.updated_at
end