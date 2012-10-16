require './scripts/app-data'
require './scripts/app'

$ ->
  admined-app-data <- $.getJSON('http://co2r-data-staging.herokuapp.com/api/app').success
  app-text         <- $.getJSON('http://co2r-data-staging.herokuapp.com/api/locale/en').success

  app_data <<< admined-app-data
  window.app-text = app-text.locale

  angular.bootstrap document.document-element, [\co2r]
