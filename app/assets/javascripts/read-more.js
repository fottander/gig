$(document).on('turbolinks:load', function() {
  $('[class^="read-more"]').click(function(element) {
    element.preventDefault()
    $(`.truncated-paragraph-${elId($(this))}`).hide()
    $(`.normal-paragraph-${elId($(this))}`).show()
  })

  $('[class^="read-less"]').click(function(element) {
    element.preventDefault()
    $(`.normal-paragraph-${elId($(this))}`).hide()
    $(`.truncated-paragraph-${elId($(this))}`).show()
  })

  function elId(element) {
    let elClassName = element.attr('class').split('-')
    return elClassName[elClassName.length - 1]
  }
});
