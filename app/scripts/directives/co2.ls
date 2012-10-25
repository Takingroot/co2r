module.exports = (m)->
  m.directive \co2, ->
    restrict: \E
    replace: yes
    template: '
      <span class="co2-keyword">
        CO<sub>2</sub>
      </span>'
