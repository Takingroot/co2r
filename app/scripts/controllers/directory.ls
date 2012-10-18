module.exports = ($scope, $http)->
  $scope.$root.page_title = \Directory

  request-artifacts-config =
    method: \GET
    url: app_data.urls.api + '/artifacts'
    params:
      language: app_data.user-language
    cache: yes

  $http(request-artifacts-config)
  .then (res)->
    $scope.artifacts = res.data.artifacts
