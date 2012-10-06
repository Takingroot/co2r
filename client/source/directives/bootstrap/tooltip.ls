directive_tooltip = ->
  (scope, el, attrs)->
    el.tooltip do
      # try-catch allows us to support variables or direct text
      # xxx is this initing hard-to-debug problems?
      try
        tooltip-config = scope.$eval attrs.tooltip
        if typeof tooltip-config is 'string'
          title: tooltip-config
        else
          tooltip-config
      catch
        # attribute is just static text?
        title: attrs.tooltip

    # teardown
    scope.$on \$destroy, ~>
      # angular $destroy event doesn't give much grainularity
      # By the time this event occurs the el has already been corrupted such that, for instance
      # el.data('popover') does not return the needed data to cleanly destroy the popover instance
      # associated with this directive instance
      #
      # Our solution therefore is much more brutish: destroy all the popover doms
      # The result is simular to the behaviour found in a traditional webpage
      $(\.tooltip).remove!
