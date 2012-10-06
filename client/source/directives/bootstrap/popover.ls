directive_popover = ($http, $compile, $interpolate)->
  (scope, el, attrs)->
    popover-config = scope.$eval attrs.popover

    # popover-config option using template file for content
    if \content_src of popover-config
      template-string <- $http.get(popover-config.content_src).success
      popover-config.content = $compile(template-string)(scope)
      el.popover popover-config
    else
      popover-config.content = $compile(popover-config.content)(scope)
      el.popover popover-config

    # teardown
    scope.$on \$destroy, ~>
      # angular $destroy event doesn't give much grainularity
      # By the time this event occurs the el has already been corrupted such that, for instance
      # el.data('popover') does not return the needed data to cleanly destroy the popover instance
      # associated with this directive instance
      #
      # Our solution therefore is much more brutish: destroy all the popover doms
      # The result is simular to the behaviour found in a traditional webpage
      $(\.popover).remove!
