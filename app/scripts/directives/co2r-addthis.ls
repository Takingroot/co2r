# Note:
#
# To use this directive the host scope must have a identifier called
# addthisShareConfig pointing to an object
#
co2r.directives

.directive \co2rAddthisToolbox, ($location)->
  restrict: \C
  replace: on
  template: '
    <div class="addthis_toolbox">
      <a class="addthis_button_facebook_like">
      <a class="addthis_button_tweet">
    </div>
  '
  link: (scope, el, attrs)->

    scope.$watch \addthisShareConfig, (custom-share-config)->
      if custom-share-config

        default-share-config =
          url: $location.abs-url!

        share-config = default-share-config <<< custom-share-config

        # Warning! multiple calls to toolbox are ignored
        # so we only have one chance to adjust the content?!
        addthis.toolbox \.addthis_toolbox, {}, share-config
