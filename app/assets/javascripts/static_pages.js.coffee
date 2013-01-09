# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#micropostRemainingCharacters: (maxLength) ->
  #$("#micropost-counter").text(140 - $("#micropost_content").val().length)

window.micropostContentLength = -> 
  $("#micropost_content").val().length

window.micropostContentRemain = (max) -> 
  max - micropostContentLength()

jQuery -> 
  $('#micropost_content').bind 'keyup', -> 
    $(".counter").text(micropostContentRemain(140))
