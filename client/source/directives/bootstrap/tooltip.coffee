directive_tooltip = ->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'tooltip', ->
      # does it look like a config object?
      if /^\{.+\}$/g.test(attrs.tooltip)
        config = scope.$eval attrs.tooltip
      # just passing a simpke title string
      else
        config = title: attrs.tooltip
      el.tooltip(config)

    # teardown
    #scope.$on "$routeChangeSuccess", ->
      #console.log 'route change'
      #el.tooltip('destroy')
