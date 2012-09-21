directive_timeline_slider = ->
  restrict:   "E"
  require:    "^timelineConductor"
  transclude: on
  replace:    on
  template: """
    <div class="timeline-slider-window" style='overflow:hidden'>
      <div class="timeline-slider jar align-center" ng-transclude></div>
    </div>
  """
  link: (scope, el, attrs, timeline)->
    timeline.register_slider el.children('.timeline-slider')
