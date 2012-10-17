module.exports = ($scope, $http)->
  $scope.$root.page_title = \Directory

  $http.get("#{app_data.urls.api}/artifacts?language=#{app_data.user-language}").success (data)->
    $scope.artifacts = data.artifacts
