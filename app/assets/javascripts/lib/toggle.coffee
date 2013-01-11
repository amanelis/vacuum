# Plugin to toggle the visibility of an element
# author: Matt Johnston

toggler = (element, options) ->
  # Default settings
  settings =
    togglee: null          # jquery element to be toggled

  # Merge default settings with options.
  settings = $.extend settings, options

  # Private instance variables
  e = $(element)

  # Simple logger.
  log = (msg) ->
    console?.log msg if settings.debug

  # toggles the element
  toggle = ->
    settings.togglee.toggle()

  # shows the element
  show = ->
    settings.togglee.show()

  # hides the element
  hide = ->
    settings.togglee.hide()

  e.click ->
    toggle()
    return false

  # Public functions
  return {
    toggle: toggle
    show: show
    hide: hide
    setup: ->

  }

$.fn.toggler = (options) ->
  $.fn.encapsulatedPlugin('toggler', toggler, this, options)

$ ->
  $('[data-toggle]').each (i, el) ->
    $(el).toggler
      togglee: $($(el).data('toggle'))