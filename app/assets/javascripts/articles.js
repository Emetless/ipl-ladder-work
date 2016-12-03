$(document).on('turbolinks:load', function() {
  $('textarea').autosize()
})

function articleValidate() {
  if ($('textarea').val() == '') {
    $('.button').blur()
  }
  else $('form').submit()
}

function bindAJAX(event) {
  var eventForm = event.target
  $(eventForm).bind('ajax:success', function(xhr, data, status) { addComment(data, eventForm) })
}

function addComment(data, eventForm) {
  console.log('ajax:success')
  eventForm.reset()
  $(eventForm).children('button').blur()
  commentHTML = $('<p />')
  commentHTML.append(`${data.author} ${data.answered}<br/>${data.content}`)
  commentHTML.appendTo($(eventForm).parent())
  $(eventForm).unbind('ajax:success')
}