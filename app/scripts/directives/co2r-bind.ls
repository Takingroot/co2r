module.exports = ($compile)->
  (scope, el, attrs)->
    evaled = scope.$eval attrs.co2rBind
    if evaled.0 isnt '<'
      # just some plaintext, no need to compile
      el.html evaled
    else
      el.html $compile( evaled, attrs.co2rBind )(scope)
