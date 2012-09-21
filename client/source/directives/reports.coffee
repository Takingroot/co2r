report_directives = (app)->
  app.directive 'reportSectionTitle', ->
    restrict: "E"
    replace: on
    transclude: on
    template: """
      <h3 class="text-align-center" ng-transclude></h3>
    """

  app.directive 'reportHeaderBasic', ->
    restrict: "E"
    replace: on
    transclude: on
    template: """
      <header class="report-header">
        <h3 class="text-align-center" ><span class="report-title" ng-transclude></span></h3>
      </header>
    """
