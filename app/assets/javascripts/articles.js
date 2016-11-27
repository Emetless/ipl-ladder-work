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