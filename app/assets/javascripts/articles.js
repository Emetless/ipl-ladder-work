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
  eventForm.reset()
  $(eventForm).children('button, input').blur()
  commentHTML = $('<p />')
  commentHTML.append(`${data.author} ${data.answered}<br/>${data.content}`)
  commentHTML.appendTo($(eventForm).parent())
  $(eventForm).unbind('ajax:success')
}

function clearCommentField(event) {
  field = $(event.target)
  field.val('')
  field.css('color', '#2d2d2d')
}

function resetCommentField(event) {
  field = $(event.target)
  field.val('Add Comment')
  field.css('color', '#a3a3a3')
}