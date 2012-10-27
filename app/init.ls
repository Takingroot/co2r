require './scripts/app'
user-language = require './scripts/lib/user-language'
Preferences-storage = require './scripts/lib/preferences-storage'
preferences-storage = new Preferences-storage

window.app_data = {urls:{}}

$ ->
  users-browser-language <- user-language

  # if the user's language is not supported by our app we should restrict the app's language setting to a supported one
  supported-languages = [\en \fr]

  if users-browser-language not in supported-languages
    maybe-users-browser-language = \en
  else
    maybe-users-browser-language = users-browser-language

  app_data.user-language = preferences-storage.get-and-maybe-set \languageCode, maybe-users-browser-language
  app_data.urls.kml-data = "http://thievishfilms.s3.amazonaws.com/lccp-2012-#{app_data.user-language}.kml"



  $.getJSON("http://co2r-data-staging.herokuapp.com/api/app?language=#{app_data.user-language}")
  .then (admined-app-data)->
    app_data <<< admined-app-data
    angular.bootstrap document.document-element, [\co2r]
