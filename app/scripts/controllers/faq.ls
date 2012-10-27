module.exports = ($scope, co2r-api)->

  co2r-api.get \faqs, {cache: on}
  .then (res)->
     $scope.faqs = res.data.faqs
