function textareaStretch(event){
  var textarea = $('textarea')
  textarea.scrollTop(textarea.get(0).scrollHeight)
  var scrollHeight = textarea.scrollTop() + textarea.height()
  textarea.scrollTop(0)
  textarea.height(scrollHeight)
}

function articleValidate(){
  if ($('textarea').val() == ''){
    $('textarea').css('border-bottom', '0.15rem solid #f00')
  }
  else $('form').submit()
}

function bindAJAX(event){
  var eventForm = event.target
  $(eventForm).bind('ajax:success', function(xhr, data, status) { addComment(data, eventForm) })
}

function addComment(data, eventForm){
  eventForm.reset()
  $(eventForm).children('button').blur()
  commentHTML = $('<p />')
  commentHTML.append($.parseHTML(data.author + ' answered<br/>' + data.content))
  commentHTML.appendTo($(eventForm).parent())
}