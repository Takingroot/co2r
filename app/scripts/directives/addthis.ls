module.exports = (m)->

  m.directive \artifactAddthisToolbox, ->
    restrict: \C
    replace: on
    template: '
      <div class="addthis_toolbox">
        <a class="addthis_button_facebook_like" addthis:url="http://www.test423.com">
        <a class="addthis_button_tweet" addthis:title="{{twitterDefaultMessage}}">
      </div>
    '
    link: (scope, el, attrs)->

      scope.$watch \addthisShareConfig, (new-addthis-share-config)->
        if new-addthis-share-config
          # Warning! multiple calls to toolbox are ignored
          # so we only have one chance to adjust the content?!
          addthis.toolbox \.addthis_toolbox, {}, new-addthis-share-config
