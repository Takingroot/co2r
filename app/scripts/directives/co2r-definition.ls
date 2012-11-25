module.exports = ->
  replace:    on
  transclude: on
  template: '<a class="co2r-definition" popover="popoverConfig" ng-transclude></a>'
  link: (scope, el, attrs)->
    scope.popoverConfig = {}
    scope.$watch \app-vars.defined_terms, (new-defined-terms)->
      scope.popover-config = _.find new-defined-terms, -> it.term_name is el.text!
