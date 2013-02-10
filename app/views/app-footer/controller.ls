co2r.controller \footer, ($scope, co2r-api)->

  $scope.addthis-share-config =
    #TODO translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description



  co2r-api.get \organizations
  .then (res)->
    $scope.partners    = _.filter res.data.organizations, (.is_partner)
    $scope.taking-root = _.first _.select res.data.organizations, -> it.slug is \taking-root
