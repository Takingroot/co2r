controller_directory = ($scope, $http)->

  $http.get('http://co2r-data-staging.herokuapp.com/api/artifacts').success (data)->
    #console.log data.artifacts
    $scope.artifacts = data.artifacts

  $scope.$root.page_title = \Directory
