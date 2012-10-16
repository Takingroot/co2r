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

.filter \interpolate, ->
  (string, ...interpolations)->
    if _.is-empty interpolations
      string
    else
      _.str.sprintf string, ...interpolations
