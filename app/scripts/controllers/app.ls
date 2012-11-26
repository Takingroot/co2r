window.app-controller = ($scope, partial-path, co2r-api, preferences-storage, $filter, route-css-classes, $location)->

  $scope.appCssClasses = ""
  $scope.app-title    = "CO2R"
  $scope.partial-path = partial-path
  $scope.locale-id    = preferences-storage.get-and-maybe-set \languageCode, \en
  $scope.app-text     = {}
  $scope.app-vars     =
    urls: {}

  # update app location css classes
  $scope.$root.$on \$routeChangeSuccess, ->
    $scope.appCssClasses = route-css-classes.get-all-classes!


  $scope.get-page-title = ->
    if $scope.page-title
      " ‣ #{$scope.page-title}"
    else
      ''

  # additional app-vars from server, admin-controlled
  co2r-api.get \app
  .then (res)->
    $scope.app-vars <<< res.data



  # i18n text
  co2r-api.get "locale/#{$scope.locale-id}"
  .success (res-data)->
    $scope.app-text = res-data.locale

  # this is to aid in the language switcher functionality
  $scope.other-language = ->
    $filter(\altLanguage)($scope.locale-id)

  $scope.use-other-language = ->
    preferences-storage.set \languageCode, $scope.otherLanguage!
    window.location.reload!


  # header/footer navigation
  $scope.nav-items =

    * label: "directory"
      url: "/directory"

    * label: "register_your_product"
      url: "/register-your-product"

    * label: "other_things_you_can_do"
      url: "/other-things-you-can-do-to-help"

    * label: "our_mission"
      url: "/about"

    * label: "faq"
      url: "/faq"

  $scope.is-current-view = (test-url)->
    #console.log test-url, $location.path!, test-url is $location.path!
    test-url is $location.path!
