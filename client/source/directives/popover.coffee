directive_popover =  ->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'popover', ->
      el.popover scope.$eval(attrs.popover)

    # teardown
    scope.$root.$on "$routeChangeSuccess", -> el.popover('destroy')
