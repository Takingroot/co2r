co2r

.directive \tooltip, ($compile)->
  (scope, element, attrs)->



    #
    #  init
    #
    element.tooltip!
    prep-tooltip-destruction!



    #
    #  Data binding on the entire tooltip config
    #
    scope.$watch attrs.tooltip, (newOpts)->
      if newOpts
        # not the most effecient technique? if one option changes every single
        # option is considered changed (recalculated)
        for opt of new-opts
          #  1. we don't need to compile non-content stuff
          #  2. if html option is off, we don't need to compile content
          #  3. if the content is plaintext we don't need to compile it
          if (opt isnt \title) or (not new-opts.html) or (not $(new-opts[opt]).length)
            opt-value = new-opts[opt]
          else
            opt-value = $compile(new-opts[opt])(scope)
          element.data('tooltip').options[opt] = opt-value
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
    function prep-tooltip-destruction
      # save a tooltip reference for teardown, element
      # isn't available after $destroy evidently?
      tooltipObject = element.data \tooltip
      scope.$on \$destroy, ->
        tooltipObject.destroy!
