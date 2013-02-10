co2r

.filter \unit, ->
    (amount, requested-unit-type)->
      return amount if typeof amount isnt \number

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
    (keyword)->
      dict =
        email: \envelope-alt
        facebook: \facebook-sign
        twitter: \twitter-sign
        website: \home
        other: \link
      dict[keyword] ? keyword

.filter \slugify, ->
    ->
      component('slug') it if typeof it is \string

# return string prefixed with mailto if email flag is true
.filter \prefixMailto, ->
  (string, link-type)->
    | link-type is \email => 'mailto:' + string
    | otherwise => string

.filter \interpolate, ->
  (string, ...interpolations)->
    if _.is-empty interpolations
      string
    else
      _.str.sprintf string, ...interpolations

.filter \altLanguage, ->
  ->
    switch it
    when \en then \fr
    when \fr then \en

.filter \languageName, ->
  (language-code)->
    language-names =
      en:
        en: \English
        fr: \French
      fr:
        en: \Anglais
        fr: \Francais
    language-names[language-code][language-code]

.filter \castToDate, ->
  (date-string)->
    new Date date-string
