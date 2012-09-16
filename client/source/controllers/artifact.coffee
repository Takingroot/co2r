controller_artifact = ($scope, $routeParams)->
  $scope.artifact = _.find artifacts, (artifact)-> artifact.slug is $routeParams.artifact
