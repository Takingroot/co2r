module.exports = ($scope, partial-path, co2r-api, preferences-storage, $filter, route-css-classes, $location)->

  $scope.appCssClasses = ""
  $scope.app_title    = "CO2R"
  $scope.partial-path = partial-path
  $scope.locale-id    = preferences-storage.get-and-maybe-set \languageCode, \en
  $scope.app-text     = {}
  $scope.app-vars     =
    urls:
      introduction-figure: "http://upload.wikimedia.org/wikipedia/commons/c/c0/Blank.gif"

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
    console.log $scope.app-text

  # this is to aid in the language switcher functionality
  $scope.other-language = ->
    $filter(\altLanguage)($scope.locale-id)

  $scope.use-other-language = ->
    preferences-storage.set \languageCode, $scope.otherLanguage!
    window.location.reload!


  # header/footer navigation
  nav-items =
    * label: "co2r"
      url: "/directory"

    * label: "our_mission"
      url: "/about"

    * label: "faq"
      url: "/faq"

    * label: "register_your_product"
      url: "/register-your-product"

    * label: "other_things_you_can_do"
      url: "/other-things-you-can-do-to-help"

  $scope.navs =
    primary: do -> _.filter nav-items, -> _.contains(<[co2r our_mission faq]>, it.label)
    callout: do -> _.filter nav-items, -> _.contains(<[register_your_product other_things_you_can_do]>, it.label)
    footer: nav-items


  $scope.is-current-view = (test-url)->
    #console.log test-url, $location.path!, test-url is $location.path!
    test-url is $location.path!


  # responsive design via conditional class application
  $scope.w-mobile = no

  enquire.register "screen and (max-width:980px)",
    match:   ->
      #console.log \match
      $scope.$apply -> $scope.w-mobile = yes
    unmatch: ->
      #console.log \unmatch
      $scope.$apply -> $scope.w-mobile = no

  # wait until first idle, i.e after angular gets one pass-through
  # if we don't delay, the $apply above causes a bug (ng-view never loads, no error message)
  _.delay (-> enquire.listen(50)), 0
