co2r

.directive \popover, ($compile)->
  (scope, element, attrs)->



    #
    #  init
    #
    element.popover!
    prep-popover-destruction!



    #
    #  Data binding on the entire popover config
    #
    scope.$watch attrs.popover, (newOpts)->
      if newOpts
        # not the most effecient technique? if one option changes every single
        # option is considered changed (recalculated)
        for opt of new-opts
          #  1. we don't need to compile non-content stuff
          #  2. if html option is off, we don't need to compile content
          #  3. if the content is plaintext we don't need to compile it
          if (opt isnt \title and opt isnt \content) or (not new-opts.html) or (not $(new-opts[opt]).length)
            opt-value = new-opts[opt]
          else
            opt-value = $compile(new-opts[opt])(scope)
          element.data('popover').options[opt] = opt-value
        element.popover \setContent
    # compare equality, not reference, thus allowing us to watch an object, array, etc.
    , true



    #
    #  BS creates popovers near the bottom of the DOM
    #  therefore if a popover is open in a destroyed scope (i.e. route change -> view change)
    #  its markup will stay stagnant in the page, and visually a popover will be hovering
    #  aimlessly on the page, unable to be closed by the user!
    #
    #  This function handles the above case
    #
    function prep-popover-destruction
      # save a popover reference for teardown, element
      # isn't available after $destroy evidently?
      popoverObject = element.data \popover
      scope.$on \$destroy, ->
        popoverObject.destroy!














    /*
    attrs.$observe \popover, (popover-config-string)->
      popover-config = scope.$eval popover-config-string

      if typeof popover-config is \object

        # bootstrap popovers must be destroyed
        # in order to re-instantiate
        el.popover \destroy

        if \contentSrc of popover-config
          # popover-config option using template file for content
          $http.get(popover-config.content-src).success (template-string)->
            popover-config.content = $compile(template-string)(scope)
            el.popover popover-config
            prepare-teardown!
        else if \contentToCompile of popover-config
          popover-config.content = $compile(popover-config.contentToCompile)(scope)
          el.popover popover-config
          prepare-teardown!
        else
          el.popover popover-config
          prepare-teardown!


    function prepare-teardown
      # save a reference for teardown, el
      # isn't available after $destroy
      popover = el.data \popover

      # teardown
      scope.$on \$destroy, ~>
        popover.destroy!
    */
