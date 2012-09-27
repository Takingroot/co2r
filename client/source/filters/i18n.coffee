filter_i18n = (app)->
  app.filter 'i18n', ($locale, preferencesStorage)->
    (locale_key, string_args...)->

      get_locale = ->
        language_code = $locale.id.substring(0, ($locale.id.indexOf('-')))
        if app_locales.hasOwnProperty(language_code)
          app_locales[language_code]
        else
          # users locale is not supported, use default locale instead
          app_locales[preferencesStorage.get('locale')]

      localized_string = _.traverse(get_locale(), locale_key)

      if string_args.length
        _.str.sprintf(localized_string, string_args... )
      else
        localized_string
