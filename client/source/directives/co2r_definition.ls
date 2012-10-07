directive_co2r_definition = (app)->

  app.directive \co2rDefinition, ->
    replace:    on
    transclude: on
    template: """<a class="co2r-definition" ng-transclude></a>"""
    link: (scope, el, attrs)->

      popover = ->
        defined-term = _.first _.select(scope.app_data.defined_terms, -> it.term_name is el.text!)
        if defined-term
          el.popover defined-term

      popover!

      scope.$watch 'app_data.defined_terms', (new_val, old_val)->
        popover! if new_val isnt old_val

      # save a reference for teardown, el
      # isn't available after $destroy
      popover-obj = el.data \popover

      # teardown
      scope.$on \$destroy, ~> popover-obj.destroy!
