co2r

.directive \spyscrollable, ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->

      #
      #  do $anchorScroll on init so that
      #  a page anchor in the url on page
      #  load will work (the page will be
      #  scrolled to the correct anchor point)
      #
      $anchorScroll!

      #  kick off Boostrap scrollspy
      #  docs: http://twitter.github.com/bootstrap/javascript.html#scrollspy
      $ document.body .scrollspy \refresh
