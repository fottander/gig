json.array! @notifications do |notification|
  json.created_at notification.created_at.strftime("%b %d %R")
  json.actor notification.actor.username
  json.action notification.action
  json.job_id notification.job_id
  json.notifiable do
    json.type "#{notification.notifiable.class.model_name.human.downcase}"
  end
  json.url job_application_path(notification.notifiable.job_id, notification.notifiable.application_id)
end