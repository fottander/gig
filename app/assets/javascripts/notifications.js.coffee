class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      "<a class='portfolio-resume-notice-items' href='#{notification.url}'>#{notification.created_at} <span class='notification-link'>#{notification.action} #{notification.notifiable.type}</span> från #{notification.actor}</a><br>"
    $("[data-behavior='notification-items']").html(items.slice(-10))

jQuery ->
  $(document).on 'turbolinks:load', ->
    new Notifications
