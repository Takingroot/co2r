co2r.controllers.controller \app, ($scope, co2r-api, preferences-storage, $filter, route-css-classes)->

  $scope.locale-id     = preferences-storage.get-and-maybe-set \languageCode, \en

  # update app location css classes
  $scope.$root.$on \$routeChangeSuccess, ->
    $scope.app-css-classes = route-css-classes.get-all-classes!


  #  helper function for setting the browser-window title
  #  any controller can access this function via skype
  #  so page/<controller> can use it to modify the browser-window title, etc.

  $scope.get-page-title = ->
    base-title = "CO2R"
    if $scope.page-title
      "#{base-title} ‣ #{$scope.page-title}"
    else
      base-title

  #
  #  admin-controlled app-vars
  #  (variables that footrpint charting, term defintions, etc.)

  co2r-api.get(\app).then (res)->
    $scope.app-vars = res.data


  #
  #  i18n data, text for the app

  co2r-api.get("locale/#{$scope.locale-id}").success (res-data)->
    $scope.app-text = res-data.locale
