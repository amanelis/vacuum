$ ->
  $(document).foundation()

  # Notifications form validation
  $("#notifications_form").submit (evt) ->
    evt.preventDefault()
    $("#notification_name").removeClass "error"
    $("#notification_email").removeClass "error"
    $("#notifications_name_error").empty()
    $("#notifications_email_error").empty()
    error = false
    name = $("#notification_name").val()
    email = $("#notification_email").val()
    project_id = $("#notification_project_id").val()
    if name is "" or not name? or name is `undefined`
      $("#notification_name").addClass "error"
      $("#notifications_name_error").html "<div class=\"alert-box alert\">Add a name<a href=\"\" class=\"close\">&times;</a></div>"
      error = true
    if email is "" or not email? or email is `undefined`
      $("#notification_email").addClass "error"
      $("#notifications_email_error").html "<div class=\"alert-box alert\">Add an email<a href=\"\" class=\"close\">&times;</a></div>"
      error = true
    if error
      false
    else
      @submit()

  # Collaborators form validation
  $("#collaborators_form").submit (evt) ->
    evt.preventDefault()
    $("#collaborator_email").removeClass "error"
    $("#collaborators_email_error").empty()
    error = false
    email = $("#collaborator_email").val()
    project_id = $("#collaborator_project_id").val()
    if email is "" or not email? or email is `undefined`
      $("#collaborator_email").addClass "error"
      $("#collaborators_email_error").html "<div class=\"alert-box alert\">Add an email<a href=\"\" class=\"close\">&times;</a></div>"
      error = true
    if error
      false
    else
      @submit()

  # Payment form
  $('form#charge_form').submit (evt) ->
    evt.preventDefault
    _this = $(this)

    $('span.payment-errors').empty()

    Stripe.createToken
      number:     $("#card_number").val()
      cvc:        $("#card_cvc").val()
      exp_month:  $("#expiry_month").val()
      exp_year:   $("#expiry_year").val()
    , stripeResponseHandler

  stripeResponseHandler = (status, response) ->
    if response.error

      # show the errors on the form
      $("span.payment-errors").text response.error.message
    else
      form$ = $("form#charge_form")

      # token contains id, last4, and card type
      token = response["id"]

      # insert the token into the form so it gets submitted to the server
      form$.append "<input type='hidden' name='stripeToken' value='" + token + "'/>"

      # Clear the fields
      $("#card_number").val('')
      $("#card_cvc").val('')
      $("#expiry_month").val('')
      $("#expiry_year").val('')

      # and submit
      form$.get(0).submit()


  # Text area for script tag, auto highlight
  $("textarea#codebox").click ->
    @focus()
    @select()

  # Resolve error ajax functionality for error#show page
  $resolveForm = $('#resolve-error')
  if $resolveForm.length
    $resolveForm.find(':input').change (e) ->
      $.ajax
        url: "#{$resolveForm.attr('action')}/resolve",
        data: $resolveForm.serialize()

  $errorCheckboxes = $('.error-checkbox')
  if $errorCheckboxes.length

    # Select/deselect all checkbox functionality
    $('#check-all').on 'change', (e) ->
      $errorCheckboxes.prop('checked', $(e.target).prop('checked')).change()

    $actions = $('.action-on-selected')
    $errorCheckboxes.on 'change', (e) ->
      $actions.attr('disabled', !_.some(_.pluck($errorCheckboxes, 'checked')))

    $errorForm = $('#error-form')
    $actions.each (i, el) ->
      $el = $(el)
      action = $el.data('action')
      $el.click ->
        unless $el.is(':disabled')
          $errorForm.attr('action', action).submit()