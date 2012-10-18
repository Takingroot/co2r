module.exports = ($scope, $http)->
  $scope.$root.page_title = \Directory

  get-artifacts-config =
    url: app_data.urls.api + '/artifacts'
    method: \GET
    params: language: app_data.user-language
    cache: yes

  $http get-artifacts-config
  .then (res)->
    $scope.artifacts = res.data.artifacts
