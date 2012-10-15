module.exports = ($scope, $http)->
  $scope.$root.page_title = \Directory

  $http.get('http://co2r-data-staging.herokuapp.com/api/artifacts').success (data)->
    $scope.artifacts = data.artifacts
