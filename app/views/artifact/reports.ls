co2r

.directive \reportSectionTitle, ->
  restrict:   \C
  replace:    on
  transclude: on
  template: """
    <h3 class="text-align-center" ng-transclude></h3>
  """

.directive \reportHeaderBasic, ->
  restrict:   \C
  replace:    on
  transclude: on
  template: """
    <header class="report-header">
      <h3 class="jar align-center report-title" ng-transclude></h3>
    </header>
  """
