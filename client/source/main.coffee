window.CO2R = angular.module('meteorapp', ['ngSanitize', 'ui'])

config_routes()


CO2R.filter "unit", ->
  (input, type)->
    switch type
      when 'kg'
        return "#{input*1000} kg"

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])

CO2R.directive 'popover', ->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'popover', ->
      el.popover scope.$eval(attrs.popover)

    # teardown
    scope.$root.$on "$routeChangeSuccess", -> el.popover('destroy')

CO2R.directive 'spyscrollable', ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->
      $anchorScroll()
      $('body').scrollspy('refresh')

CO2R.directive 'anchorable', ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->
      $anchorScroll()


CO2R.directive 'tooltip', ->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'tooltip', ->
      el.tooltip(title: attrs.tooltip)

    # teardown
    scope.$root.$on "$routeChangeSuccess", -> el.tooltip('destroy')

CO2R.directive 'affix', ->
  (scope, el, attrs)->
    # setup
    attrs.$observe 'affix', ->
      el.affix offset: attrs.affix or 0

CO2R.run ($rootScope)->
  window.$rootScope = $rootScope

CO2R.directive 'smoothScroll', ($location)->
  (scope, el, attrs)->
    $body = $ document.body
    attrs.$observe 'href', ->
      el.click ->
        position_top = $(attrs.href).offset()?.top
        if position_top?
          $body.animate({scrollTop: position_top}, "fast")
          #scope.apply -> $location.hash attrs.id
          off
CO2R.factory 'preferencesStorage', ->
  new PreferencesStorage
    show_introduction: yes
