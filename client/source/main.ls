
CO2R = angular.module('co2r', ['ngSanitize', 'ui'])

config-routes(CO2R)

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])

CO2R.filter "unit", filter_unit
CO2R.filter "to_icon_name", filter_to_icon_name
CO2R.filter "slugify", filter_slugify

CO2R.directive 'spyscrollable', directive_spyscrollable
CO2R.directive 'popover',       directive_popover
CO2R.directive 'anchorable',    directive_anchorable
CO2R.directive 'tooltip',       directive_tooltip
CO2R.directive 'smoothScroll',  directive_smooth_scroll
CO2R.directive 'tab',           directive_tab
CO2R.directive 'carousel',      directive_carousel
CO2R.directive 'carouselItem',  directive_carousel_item
CO2R.directive 'co2Contrasted', directive_co2_contrasted
CO2R.directive 'timelineSlider',directive_timeline_slider
CO2R.directive 'timelineConductor',directive_timeline_conductor
report_directives(CO2R)
directive_scroll_fix_bottom(CO2R)
directive_bar_chart(CO2R)
directive_co2r_definition(CO2R)
directive_co2r_bind(CO2R)
filter_i18n(CO2R)

CO2R.factory 'preferencesStorage', service_preferences_storage



<- $
admined-app-data <- $.getJSON('http://co2r-data-staging.herokuapp.com/api/app').success

app_data <<< admined-app-data
angular.bootstrap document.document-element, ['co2r']
