module.exports = ($scope, co2r-api, preferences-storage)->

  $scope.preferences = preferences-storage

  $scope.$root.page-title = ''

  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description

  co2r-api.get \artifacts, {cache: yes}
  .then (res)->
    $scope.artifacts = res.data.artifacts
