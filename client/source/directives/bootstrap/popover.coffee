directive_popover = ($http, $compile, $interpolate)->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'popover', ->
      config = scope.$eval(attrs.popover)

      # config option using template file for content
      if config.hasOwnProperty("content_src")
        $http.get(config.content_src).success (template_string)->
          config.content = $compile(template_string)(scope)
          el.popover config
      else
        config.content = $compile(config.content)(scope)
        el.popover config

    # teardown
    scope.$on '$destroy', (a)=>
      # angular $destroy event doesn't give much grainularity
      # By the time this event occurs the el has already been corrupted such that, for instance
      # el.data('popover') does not return the needed data to cleanly destroy the popover instance
      # associated with this directive instance
      #
      # Our solution therefore is much more brutish: destroy all the popover doms
      # The result is simular to the behaviour found in a traditional webpage
      $(".popover").remove()
