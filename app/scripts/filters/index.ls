angular.module \co2r.filters, []

.filter \unit, ->
    (amount, requested-unit-type)->

      unit-types =
        t:  -> "#it t"
        kg: -> "#{it*1000} kg"

      unit-type-fn = unit-types[requested-unit-type]

      if not unit-type-fn then throw "
        The unit type '#requested-unit-type' 
        is not supported on CO2R. You are limited to: 
        #{_.keys unit-types}."
      else
        unit-type-fn amount



.filter \to_icon_name, ->
    (keyword)-> { email: \envelope }[keyword] ? keyword

.filter \slugify, ->
    -> _.str.slugify it

# return string prefixed with mailto if email flag is true
.filter \prefixMailto, ->
  (string, link-type)->
    | link-type is \email => 'mailto:' + string
    | otherwise => string


.filter \i18n, ($locale, preferencesStorage)->
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
