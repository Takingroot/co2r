require './scripts/app-data'
require './scripts/app'
user-language = require './scripts/user-language'
Preferences-storage = require './scripts/preferences-storage'
preferences-storage = new Preferences-storage

$ ->
  users-browser-language <- user-language
  user-language = preferences-storage.get-and-maybe-set \languageCode, users-browser-language

  admined-app-data <- $.getJSON("#{app_data.urls.api}/app?language=#user-language").success
  app-text         <- $.getJSON("#{app_data.urls.api}/locale/#user-language").success

  app_data <<< admined-app-data
  app_data.user-language = user-language
  app_data.urls.kml-data = "http://thievishfilms.s3.amazonaws.com/lccp-2012-#user-language.kml"
  window.app-text = app-text.locale

  angular.bootstrap document.document-element, [\co2r]
