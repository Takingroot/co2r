#
# Depends on:
# - CO2R global
# - vendor/angular
#
CO2R.config(['$routeProvider', ($routeProvider)->
  $routeProvider.when('/directory',  {templateUrl: "#{app_settings.static_url}templates/directory.html",  controller: controllers.directory})
  $routeProvider.when('/about',      {templateUrl: "#{app_settings.static_url}templates/about.html",      controller: controllers.about})
  $routeProvider.otherwise({redirectTo: '/directory'})
])
