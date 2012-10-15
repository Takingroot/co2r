module.exports = (m)->
  m.directive \popover, ($http, $compile, $interpolate)->
    (scope, el, attrs)->
      popover-config = scope.$eval attrs.popover

      # popover-config option using template file for content
      if \contentSrc of popover-config
        template-string <- $http.get(popover-config.content-src).success
        popover-config.content = $compile(template-string)(scope)
        el.popover popover-config
        prepare-teardown!
      else
        popover-config.content = $compile(popover-config.content)(scope)
        el.popover popover-config
        prepare-teardown!


      function prepare-teardown
        # save a reference for teardown, el
        # isn't available after $destroy
        popover = el.data \popover

        # teardown
        scope.$on \$destroy, ~>
          popover.destroy!
