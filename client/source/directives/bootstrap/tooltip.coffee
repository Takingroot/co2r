directive_tooltip = ->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'tooltip', ->
      # does it look like a config object?
      if /^\{.+\}$/g.test(attrs.tooltip)
        config = scope.$eval attrs.tooltip
      # just passing a simpke title string
      else
        config = title: attrs.tooltip
      el.tooltip(config)

    # teardown
    scope.$on '$destroy', (a)=>
      # angular $destroy event doesn't give much grainularity
      # By the time this event occurs the el has already been corrupted such that, for instance
      # el.data('popover') does not return the needed data to cleanly destroy the popover instance
      # associated with this directive instance
      #
      # Our solution therefore is much more brutish: destroy all the popover doms
      # The result is simular to the behaviour found in a traditional webpage
      $(".tooltip").remove()
