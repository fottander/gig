json.array! @notices do |notice|
  json.created_at notice.created_at.strftime("%b %d %R")
  json.actor notice.actor.username
  json.action notice.action
  json.job_id notice.job_id
  json.application_id notice.application_id
  json.notifiable do
    json.type "#{notice.notifiable.class.model_name.human.downcase}"
  end
  if notice.notifiable_type == "Invoice"
    json.url dashboards_path(anchor: "2")
  else
    json.url job_application_path(notice.job_id, notice.application_id)
  end
end
