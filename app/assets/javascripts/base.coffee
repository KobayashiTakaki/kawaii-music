page = 1
$(document).on 'turbolinks:load', () ->
  Rails.fire($("#get-tracks")[0], 'submit')

  $("#show-more").on 'click', () ->
    page += 1
    $("#tracks_page").val(page)
    Rails.fire($("#get-tracks")[0], 'submit')
