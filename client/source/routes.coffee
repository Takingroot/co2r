do_routes = ->
  console.log 'doing routes'
  #
  # Depends on:
  # - CO2R global
  # - vendor/angular
  #
  CO2R.config(['$routeProvider', ($routeProvider)->
    $routeProvider.when('/directory',  {templateUrl: "directory.html",  controller: controllers.directory})
    $routeProvider.when('/about',      {templateUrl: "about.html",      controller: controllers.about})
    $routeProvider.otherwise({redirectTo: '/directory'})
  ])
