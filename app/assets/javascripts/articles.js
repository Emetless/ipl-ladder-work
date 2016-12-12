var internatoinAddComment

$(document).on('turbolinks:load', function() {
  internatoinAddComment = $('.input.comment').val()
  $('textarea').autosize()
})

function articleValidate() {
  if($('textarea').val() == '') {
    $('.button').blur()
  }
  else $('form').submit()
}

function commentValidate(event) {
  button = $(event.target)
  button.blur()
  form = button.parent().children('form')
  comment = form.children('.input.comment').val()
  if((comment != internatoinAddComment) && (comment != '')) {
    form.submit()
  }
}

function bindAJAX(event) {
  var eventForm = event.target
  $(eventForm).bind('ajax:success', function(xhr, data, status) { addComment(data, eventForm) })
}

function addComment(data, eventForm) {
  eventForm.reset()
  $(eventForm).children('button, input').blur()
  commentHTML = $('<p />')
  if(data.content != '') {
    button = `<button onclick='deleteComment(event, ${data.id})', class='flat-button' >${data.destroy}</button>`
    content = $('<span>'+data.content+'</span>').text()
    commentHTML.append(`${data.author} ${data.answered} ${button} <br/>${content}`)
    commentHTML.appendTo($(eventForm).parent())
  }
  $(eventForm).unbind('ajax:success')
}

function clearCommentField(event) {
  field = $(event.target)
  if(field.val() == internatoinAddComment) {
    field.val('')
  }
  field.css('color', '#2d2d2d')
}

function resetCommentField(event) {
  field = $(event.target)
  if(field.val() == '') {
    field.val(internatoinAddComment)
  }
  field.css('color', '#a3a3a3')
}

function deleteComment(event, id) {
  $(event.target).blur()
  $.ajax({
    url: `/comments/destroy.json?comment[id]=${id}`,
    type: 'DELETE',
    success: function(result) {
      if(result.success)
        $(event.target).parent().remove()
    }
  });
}
