directive_co2r_bind = (app)->

  app.directive 'co2rBind', ($compile)->
    (scope, el, attrs)->
      el.html $compile( scope.$eval(attrs.co2rBind), attrs.co2rBind )(scope)
