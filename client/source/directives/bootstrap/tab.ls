CO2R.directive 'tab', ->
  (scope, el, attrs)->
    el.click (e)->
      e.preventDefault!
      $(this).tab \show
