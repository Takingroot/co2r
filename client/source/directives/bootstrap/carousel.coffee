directive_carousel = ->
  restrict: "E"
  transclude: on
  replace: on
  controller: ($element)->
    slides = []
    @register_slide = (new_slide)->
      slides.push new_slide
      $element.carousel()
  template: """
    <div class="carousel" ng-transclude>
    </div>
  """

directive_carousel_item = ->
  restrict: "E"
  require: "^carousel"
  transclude: on
  replace: on
  template: """
    <div class="item">
      <img ng-src="{{src}}">
      <div class="carousel-caption", ui-if="caption", ng-bind-html="caption"></div>
    </div>
  """
  link: (scope, el, attrs, carousel)->

    attrs.$observe 'caption', -> scope.caption = attrs.caption
    attrs.$observe 'src',     -> scope.src = attrs.src
    carousel.register_slide el
