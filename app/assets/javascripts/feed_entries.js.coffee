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
