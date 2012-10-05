controller_faq = ($scope, $http)->
  $http.get('http://co2r-data-staging.herokuapp.com/api/faqs').success (data)->
    $scope.faqs = data.faqs
