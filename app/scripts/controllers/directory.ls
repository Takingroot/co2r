co2r.controllers.controller \directory, ($scope, co2r-api, preferences-storage)->

  $scope.$root.page-title = ''

  $scope.introduction-state  = -> preferences-storage.get \showIntroduction
  $scope.toggle-introduction = ->
    preferences-storage.set \showIntroduction, !preferences-storage.get('showIntroduction')

  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description

  co2r-api.get \artifacts, {cache: yes}
  .then (res)->
    $scope.artifacts = res.data.artifacts
