filter_unit = ->
  (input, type)->
    switch type
      when 'kg'
        return "#{input*1000} kg"

filter_to_icon_name = ->
  (input)->
    switch input
      when 'email' then 'envelope'
      else input

filter_slugify = ->
  (input)->
    _.str.slugify input
