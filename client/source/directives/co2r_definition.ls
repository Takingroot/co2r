CO2R.directive \co2rDefinition, ->
  replace:    on
  transclude: on
  template: """<a class="co2r-definition" popover="popoverConfig" ng-transclude></a>"""
  link: (scope, el, attrs)->

    scope.popover-config = _.find scope.app_data.defined_terms, -> it.term_name is el.text!
