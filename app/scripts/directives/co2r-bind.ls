module.exports = ($compile)->
  (scope, el, attrs)->
    scope.$watch attrs.co2r-bind, (value)->
      # if value is undefined then maybe there is an error
      # in the content within co2r-bind?
      if value?
        if value.0 isnt '<'
        # must be plaintext, thus no need to compile?
        # TODO is ^ a true assumption?
          el.html value
        else
          el.html $compile(value)(scope)
