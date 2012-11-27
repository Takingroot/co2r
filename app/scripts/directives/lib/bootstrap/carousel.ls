co2r.directives

.directive \carousel, ->
  restrict:   \C
  controller: ($element)->
    @slides         = []
    @register-slide = (new-slide)->
      @slides.push new-slide
      # re-invoke carousel to include new slide
      $element.carousel!

.directive \carouselItem, ->
  restrict:   \C
  require:    \^carousel
  transclude: on
  replace:    on
  template: """
    <div class="item">
      <img ng-src="{{src}}">
      <div class="carousel-caption", ui-if="caption", ng-bind-html="caption"></div>
    </div>
    """
  link: (scope, el, attrs, carousel)->
    scope.caption = scope.$eval attrs.caption
    scope.src     = scope.$eval attrs.src
    carousel.register-slide el
