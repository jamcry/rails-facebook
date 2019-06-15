# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Focus on new comment field when 'Comment' button is clicked
  $ ->
    $('a[id="comment-btn"]').click (e) ->
      e.preventDefault();
      newCommentSelector = "#" + $(this).data("comment-form-id");
      $(newCommentSelector).focus();