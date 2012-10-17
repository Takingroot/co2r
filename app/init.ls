require './scripts/app-data'
require './scripts/app'
user-language = require './scripts/user-language'
Preferences-storage = require './scripts/preferences-storage'
preferences-storage = new Preferences-storage

$ ->
  users-browser-language <- user-language

  # if the user's language is not supported by our app we should restrict the app's language setting to a supported one
  supported-languages = [\en \fr]

  if users-browser-language not in supported-languages
    maybe-users-browser-language = \en
  else
    maybe-users-browser-language = users-browser-language

  user-language = preferences-storage.get-and-maybe-set \languageCode, maybe-users-browser-language

  admined-app-data <- $.getJSON("#{app_data.urls.api}/app?language=#user-language").success
  app-text         <- $.getJSON("#{app_data.urls.api}/locale/#user-language").success

  app_data <<< admined-app-data
  app_data.user-language = user-language
  app_data.urls.kml-data = "http://thievishfilms.s3.amazonaws.com/lccp-2012-#user-language.kml"
  window.app-text = app-text.locale

  angular.bootstrap document.document-element, [\co2r]
