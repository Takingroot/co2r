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

      scope.$on '$destroy', ~>
        # angular $destroy event doesn't give much grainularity
        # By the time this event occurs the el has already been corrupted such that, for instance
        # el.data('popover') does not return the needed data to cleanly destroy the popover instance
        # associated with this directive instance
        #
        # Our solution therefore is much more brutish: destroy all the popover doms
        # The result is simular to the behaviour found in a traditional webpage
        $(".popover").remove()
