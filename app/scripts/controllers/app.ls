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


    $scope.is-current-view = (test-url)->
      test-url is $location.path!


  # this is to aid in the language switcher functionality
  $scope.other-language = ->
    $filter(\altLanguage)($scope.locale-id)

  $scope.use-other-language = ->
    preferences-storage.set \languageCode, $scope.otherLanguage!
    window.location.reload!

  # i18n text
  co2r-api.get "locale/#{$scope.locale-id}"
  .success (res-data)->
    $scope.app-text = res-data.locale

    # We have to wait for appText before rendering navigation
    # because the tooltip won't work with nav-tooltip-config otherwise

    # header/footer navigation
    $scope.nav-items =

      * label: "directory"
        url: "/directory"
        icon: \th
        tooltip-content: "Discover products that offset their carbon footprint."

      * label: "register_your_product"
        url: "/register-your-product"
        icon: \edit
        tooltip-content: "Do you have a product or service that you’d like to offset? Get started."

      * label: "other_things_you_can_do"
        url: "/participate"
        icon: \heart
        tooltip-content: "Other ways you can help. Spread the word, sponsor us, and more."

      * label: "our_mission"
        url: "/mission"
        icon: \leaf
        tooltip-content: "We want to create a cleaner and fairer world for the future."

      * label: "faq"
        url: "/faq"
        icon: \info-sign
        tooltip-content: "How is CO2 measured? What is an offset? Who profits? and more."

    _.each $scope.nav-items, ->
      it.tooltip-config = {placement:\bottom, classes:'nav-item', titleToCompile:render-tooltip-content(it)}

    function render-tooltip-content(nav-item)
      "
        <h1 class='text-heading4 tooltip-content-title'>{{appText.#{nav-item.label}}}</h1>
        <div class='text-small tooltip-content-body'>#{nav-item.tooltip-content}</div>
      "

  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description
