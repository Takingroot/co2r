co2r.directives

.directive \popover, ($http, $compile, $interpolate)->
  (scope, el, attrs)->

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
