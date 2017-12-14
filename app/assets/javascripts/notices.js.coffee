class Notices
  constructor: ->
    @notices = $("[data-behavior='notices']")
    @setup() if @notices.length > 0

  setup: ->
    $.ajax(
      url: "/notices.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleSuccess: (data) =>
    items = $.map data, (notice) ->
      "<a class='portfolio-resume-subheader-items' href='#{notice.url}'>#{notice.created_at} <span class='notification-link'>#{notice.action} #{notice.notifiable.type}</span> - #{notice.actor}</a><br><br>"
    $("[data-behavior='notice-items']").html(items.slice(-10))

jQuery ->
  $(document).on 'turbolinks:load', ->
    new Notices
