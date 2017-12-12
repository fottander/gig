json.array! @notifications do |notification|
  json.id notification.id
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable do
    json.type "#{notification.notifiable.class.model_name.human.downcase}"
  end
  json.url applications_path(notification.notifiable.application, anchor: dom_id(notification.notifiable))
end
