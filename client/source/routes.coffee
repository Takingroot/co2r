config_routes = ->
  CO2R.config(['$routeProvider', ($routeProvider)->
    $routeProvider.when('/directory',                         {templateUrl: "partials/directory.html",      controller: controller_directory})
    $routeProvider.when('/',                                  {templateUrl: "partials/directory.html",      controller: controller_directory})
    $routeProvider.when('/about',                             {templateUrl: "partials/about.html",          controller: controller_about})
    $routeProvider.when('/faq',                               {templateUrl: "partials/faq.html",            controller: controller_faq})
    $routeProvider.when('/register-your-product',             {templateUrl: "partials/register.html",       controller: controller_register})
    $routeProvider.when('/other-things-you-can-do-to-help',   {templateUrl: "partials/other_things.html",   controller: controller_other_things})
    $routeProvider.otherwise({templateUrl: 'partials/artifact.html',   controller: controller_artifact})
  ])
