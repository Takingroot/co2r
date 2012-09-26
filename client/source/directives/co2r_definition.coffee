directive_co2r_definition = (app)->

  app.directive 'co2rDefinition', ->
    replace:    on
    transclude: on
    template: """<a class="co2r-definition" popover="popover_config" ng-transclude></a>"""
    link: (scope, el, attrs)->
      scope.popover_config = app_definitions[el.text()]
