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



  get-app-data = $.getJSON("#{app_data.urls.api}/app?language=#user-language")
                  .then (admined-app-data)->
                    app_data <<< admined-app-data

  get-i18n-data = $.getJSON("#{app_data.urls.api}/locale/#user-language")
                   .then (app-text)->
                     app_data.user-language = user-language
                     app_data.urls.kml-data = "http://thievishfilms.s3.amazonaws.com/lccp-2012-#user-language.kml"
                     # make i18n data available to whole application
                     # TODO Since app-text is sent to templates via scope
                     # should we just make this into a service?
                     window.app-text = app-text.locale

  $.when get-app-data, get-i18n-data
   .done -> angular.bootstrap document.document-element, [\co2r]
