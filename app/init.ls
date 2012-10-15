require './locales'
require './scripts/app-data'
require './scripts/app'

$ ->
  admined-app-data <- $.getJSON('http://co2r-data-staging.herokuapp.com/api/app').success

  app_data <<< admined-app-data

  angular.bootstrap document.document-element, [\co2r]
