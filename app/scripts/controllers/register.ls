module.exports = ($scope, $http)->

  $scope.submit = (e)->

    NA    = "Not given"
    email =
      subject: "Artifact registration"
      message: """
        name:    #{$scope.org.name    or NA}
        email:   #{$scope.org.email   or NA}
        phone:   #{$scope.org.phone   or NA}

        #{$scope.org.message or NA}
      """


    $http.post "#{app_data.urls.api}/email", email
    .then do
      (res)-> console.log \success!; console.dir res
      (res)-> console.log \error!; console.dir res
