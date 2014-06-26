# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->
  $(document).on 'click', 'a.edit-comment', () ->
    button = $(this)
    comment_container = button.closest('.comment').find('.comment-content')
    comment_container.data('old-content', comment_container.html())
    comment_container.html(window.loading_animation())
    $.get(button.data('url')).success (data) ->
      comment_container.html(data)
      $(document).trigger('content-changed', [comment_container])

  $(document).on 'click', 'a.cancel-edit', ()->
    button = $(this)
    comment_container = button.closest('.comment').find('.comment-content')
    old_content =  comment_container.data('old-content')
    comment_container.html(old_content)
    comment_container.data('old-content', '')
