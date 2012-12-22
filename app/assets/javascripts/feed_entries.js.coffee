# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#filters').on 'click', '#search', ->
    summary = $('#summary').val()
    title = $('#title').val()
    params = []
    params.push "summary=#{summary}" if summary
    params.push "title=#{summary}" if title
    location.href= '/feed_entries?' + params.join('&')

  $('.new_comment').on 'keypress', '.comment_input', (e)->
    text_box = e.target
    if(e.keyCode == 13)
      $(text_box.form).submit()
      comment = $(text_box).val()
      $(text_box).parent().find('ul.comments').append "<li><p>#{ comment}</li></p>"
      $(text_box).val('')
    return null

  $('.edit_feed_entry').on 'change', '.feed_entry_stars', (e)->
    $(e.target.form).submit()
    return null
