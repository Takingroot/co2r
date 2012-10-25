module.exports = ($scope, $http)->

  # master this can be used to reset the form
  $scope.form-master = {}
  $scope.email       = {}

  $scope.reset-form = ->
    $scope.org = angular.copy $scope.form-master

  $scope.send-form = ->

    # format email
    NA    = "Not given"
    $scope.email =
      subject: "Artifact registration"
      message: """
        name:    #{$scope.org.name    or NA}
        email:   #{$scope.org.email   or NA}
        phone:   #{$scope.org.phone   or NA}

        #{$scope.org.message or "No message given"}
      """

    # send email
    $http.post "#{app_data.urls.api}/email", $scope.email
    .then do
      (res)->
        $('.post-artifact-registration-message').modal!
        $scope.reset-form!
        #console.log \success!; console.dir res
      (res)->
        #console.log \error!; console.dir res
