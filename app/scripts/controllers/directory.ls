module.exports = ($scope, $http)->
  $scope.$root.page_title = \Directory
  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description


  get-artifacts-config =
    url: app_data.urls.api + '/artifacts'
    method: \GET
    params: language: app_data.user-language
    cache: yes

  $http get-artifacts-config
  .then (res)->
    $scope.artifacts = res.data.artifacts
