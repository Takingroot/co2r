
CO2R.filter \i18n, ($locale, preferencesStorage)->
  (locale-key, ...interpolations)->

    get-locales = ->
      lang-code = $locale.id.substring 0, ($locale.id.indexOf \-)
      if lang-code of app_locales
        app_locales[lang-code]
      else
        # users locale is not supported, use default locale instead
        app_locales[preferencesStorage.get \locale]

    localized-string = _.traverse get-locales!, locale-key

    if _.is-empty interpolations
      localized-string
    else
      _.str.sprintf localized-string, ...interpolations

# return string prefixed with mailto if email flag is true
CO2R.filter \prefixMailto, ->
  (string, is-email)->
    | is-email  => 'mailto:' + string
    | otherwise => string

