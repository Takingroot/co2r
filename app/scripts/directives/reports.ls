module.exports = (m)->
  m.directive \reportSectionTitle, ->
    restrict:   \E
    replace:    on
    transclude: on
    template: """
      <h3 class="text-align-center" ng-transclude></h3>
    """

  m.directive \reportHeaderBasic, ->
    restrict:   \E
    replace:    on
    transclude: on
    template: """
      <header class="report-header">
        <h3 class="jar align-center report-title" ng-transclude></h3>
      </header>
    """
