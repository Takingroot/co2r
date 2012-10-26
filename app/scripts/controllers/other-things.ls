module.exports = ($scope)->
  $scope.other-things-you-can-do =
    \feedback
    \sponsor-co2r
    \recruit-company
    \spread-word

  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description




window.form-feedback-controller = ($scope, $http)->
  $scope.default-form-values = {}

  $scope.send-form = ->

    email =
      subject: "CO2R Form - Feedback"
      message: $scope.feedback.message

    $http.post app_data.urls.api + '/email', email
    .then do
      (res)->
        #console.log \success!
        $scope.feedback = angular.copy $scope.default-form-values
        $('.message-to-user-after-send').modal!
      (res)->
        #console.log \failure!

