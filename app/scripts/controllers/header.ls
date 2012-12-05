co2r.controllers.controller \header, ($scope, $location, $filter, preferences-storage, $window)->

  #
  # this is to aid in the language switcher functionality
  #

  $scope.other-language = ->
    $filter(\altLanguage)($scope.locale-id)

  $scope.use-other-language = ->
    preferences-storage.set \languageCode, $scope.otherLanguage!
    $window.location.reload!


  #
  # Navigation
  #

  # help in highlighting current navigation item
  $scope.is-current-view = (test-url)->
    test-url is $location.path!

  $scope.nav-items =
    * label: "directory"
      url: "/directory"
      icon: \th

    * label: "register_your_product"
      url: "/register-your-product"
      icon: \edit

    * label: "participate"
      url: "/participate"
      icon: \heart

    * label: "our_mission"
      url: "/mission"
      icon: \leaf

    * label: "faq"
      url: "/faq"
      icon: \info-sign

  _.each $scope.nav-items, (nav-item)->
    nav-item.tooltip-config =
      placement: \bottom
      html: yes
      classes:  'nav-item'
      title: render-tooltip-content nav-item

  function render-tooltip-content(nav-item)
    "
      <h1 class='text-heading4 tooltip-content-title'>{{appText.#{nav-item.label}}}</h1>
      <div class='text-small tooltip-content-body'>{{appText.#{nav-item.label}_nav_text_description}}</div>
    "
