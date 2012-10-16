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

    scope.isotopeFilterByName = (filter-string)->
      # filter artifacts on name
      # if the filter input is empty then show all artifacts
      css-selector = if filter-string then "[data-name*='#{filter-string.toLowerCase!}']" else \*
      el.isotope filter: css-selector
