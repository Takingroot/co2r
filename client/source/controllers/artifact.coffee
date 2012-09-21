controller_artifact = ($scope, $routeParams)->
  $scope.artifact = _.find artifacts, (artifact)-> artifact.slug is $routeParams.artifact
  $scope.column_width = 300
  $scope.timeline_width = $scope.column_width * $scope.artifact.reports.length
  $scope.data_co2_per_unit = _.sortBy(_.pluck($scope.artifact.reports, "co2_per_unit"), (item)-> -1*item)
