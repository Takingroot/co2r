controller_artifact = ($scope, $routeParams)->
  $scope.artifact = _.find artifacts, (artifact)-> artifact.slug is $routeParams.artifact
  $scope.column_width = 500
  $scope.timeline_width = $scope.column_width * $scope.artifact.reports.length
