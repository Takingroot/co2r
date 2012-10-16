module.exports = ($parse)->

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
      selector = if name then "[data-name*='#{name.toLowerCase!}']" else \*
      el.isotope filter: selector
