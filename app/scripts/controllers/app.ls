module.exports = ($scope, partial-path, co2r-api)->

  $scope.app_title    = "CO2R"
  $scope.partial-path = partial-path

  # header/footer navigation
  nav-items =
    * label: "co2r"
      url: "directory"

    * label: "our_mission"
      url: "about"

    * label: "faq"
      url: "faq"

    * label: "register_your_product"
      url: "/register-your-product"

    * label: "other_things_you_can_do"
      url: "/other-things-you-can-do-to-help"

  $scope.navs =
    primary: do -> _.filter nav-items, -> _.contains([\co2r \our_mission \faq], it.label)
    callout: do -> _.filter nav-items, -> _.contains([\register_your_product \other_things_you_can_do], it.label)
    footer: nav-items

  # i18n text
  $scope.app-text = {}

  co2r-api.get "locale/#{app_data.user-language}"
  .success (res-data)->
    $scope.app-text = res-data.locale
