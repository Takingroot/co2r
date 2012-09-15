filter_unit = ->
  (input, type)->
    switch type
      when 'kg'
        return "#{input*1000} kg"
