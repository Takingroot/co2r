module.exports = ->
  require: \^isotope
  link: (scope, el, attrs, container-el)->
    container-el.reg el
