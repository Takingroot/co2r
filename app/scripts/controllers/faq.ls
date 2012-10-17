module.exports = ($scope, $http)->
  $http.get("#{app_data.urls.api}/faqs").success (data)->
    $scope.faqs = data.faqs
