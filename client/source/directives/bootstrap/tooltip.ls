CO2R.directive 'tooltip', ->
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

    # save a reference for teardown, el
    # isn't available after $destroy
    tooltip = el.data \tooltip

    # teardown
    scope.$on \$destroy, ~> tooltip.destroy!
