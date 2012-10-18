module.exports = ($scope, $http)->

  get-faqs-config =
    url: app_data.urls.api + '/faqs'
    method: \GET
    params: language: app_data.user-language
    cache: yes

  $http get-faqs-config
  .then (res)->
     $scope.faqs = res.data.faqs
