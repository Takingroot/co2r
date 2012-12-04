co2r.directives

.directive \tooltip, (safe-compile)->
  (scope, element, attrs)->



    #
    #  init
    #
    element.tooltip!
    prepTooltipDestruction!



    #
    #  Data binding on the entire tooltip config
    #
    scope.$watch attrs.tooltip, (newOpts)->
      if newOpts
        # not the most effecient technique? if one option changes every single
        # option is considered changed (recalculated)
        for opt of newOpts
          if opt isnt \title or not new-opts.html
            opt-value = new-opts[opt]
          else
            optValue = safe-compile source:new-opts[opt], wrapper-class:"tooltip-#opt", scope:scope
          element.data('tooltip').options[opt] = optValue
        element.tooltip \setContent
    # compare equality, not reference, thus allowing us to watch an object, array, etc.
    , true



    #
    #  BS creates tooltips near the bottom of the DOM
    #  therefore if a tooltip is open in a destroyed scope (i.e. route change -> view change)
    #  its markup will stay stagnant in the page, and visually a tooltip will be hovering
    #  aimlessly on the page, unable to be closed by the user!
    #
    #  This function handles the above case
    #
    function prepTooltipDestruction
      # save a tooltip reference for teardown, element
      # isn't available after $destroy evidently?
      tooltipObject = element.data \tooltip
      scope.$on \$destroy, ->
        tooltipObject.destroy!
