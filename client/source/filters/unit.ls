filter_unit = ->
  (amount, requested-unit-type)->

    unit-types =
      t:  -> "#{it} t"
      kg: -> "#{it*1000} kg"

    unit-type-fn = unit-types[requested-unit-type]

    if not unit-type-fn then throw "
      The unit type '#{requested-unit-type}' 
      is not supported on CO2R. You are limited to: 
      #{_.keys unit-types}."
    else
      unit-type-fn amount



filter_to_icon_name = ->
  (input)->
    switch input
      when 'email' then 'envelope'
      else input

filter_slugify = ->
  -> _.str.slugify it
