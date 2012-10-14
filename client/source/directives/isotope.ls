CO2R.directive \isotope, ($parse)->


  controller: ($element)->
    @items = []
    @reg = (item-el)->
      @items.push item-el
      /*
      $element.isotope \addItems, item-el
      console.log 'add item', item-el
      $element.isotope \reLayout
      */

    exec = ->
      $element.removeClass \hidden
      $element.isotope do
        layout-mode: \masonry
      #$element.isotope(\addItems, @items)

    setTimeout exec, 1500
    #setTimeout $element.isotope(\reLayout), 1500

  link: (scope, el, attrs)->

    scope.isotopeFilterByName = (name='')->
      #console.log \filter, name
      #console.log el.children "[data-name*='#name']"

      el.isotope filter: "[data-name*='#{name.toLowerCase!}']"





CO2R.directive \isotopeItem, ->
  require: \^isotope
  link: (scope, el, attrs, container-el)->
    container-el.reg el
