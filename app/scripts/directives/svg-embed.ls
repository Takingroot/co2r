module.exports = (m)->
  m.directive \svgImage, ->
    restrict: \E
    replace: yes
    template: '<embed type="image/svg+xml" pluginspage="http://www.adobe.com/svg/viewer/install/"></embed>'
