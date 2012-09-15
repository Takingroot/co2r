directive_popover =  ($http, $compile)->
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
          el.popover config

    # teardown
    # TODO this breaks partials e.g. outside ng-view that don't get reloaded on route changes
    #scope.$root.$on "$routeChangeSuccess", -> el.popover('destroy')
