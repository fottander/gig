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
      "<a class='portfolio-resume-subheader-items' href='#{notification.url}'>#{notification.created_at}<br> #{notification.action} #{notification.notifiable.type} i chatten från #{notification.actor}</a><br><br>"
    $("[data-behavior='notification-items']").html(items)

jQuery ->
  $(document).on 'turbolinks:load', ->
    new Notifications
