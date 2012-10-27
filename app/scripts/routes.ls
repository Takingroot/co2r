CO2R.config ($routeProvider, partialPath)->
  $routeProvider.when '/',                                  {templateUrl: partial-path(\directory),      controller: \directory}
  $routeProvider.when '/directory',                         {templateUrl: partial-path(\directory),      controller: \directory}
  $routeProvider.when '/about',                             {templateUrl: partial-path(\about),          controller: \about}
  $routeProvider.when '/faq',                               {templateUrl: partial-path(\faq),            controller: \faq, reload-on-search: no}
  $routeProvider.when '/register-your-product',             {templateUrl: partial-path(\register),       controller: \register}
  $routeProvider.when '/other-things-you-can-do-to-help',   {templateUrl: partial-path(\other-things),   controller: \other-things}
  $routeProvider.when '/test',                              {templateUrl: partial-path(\test),           controller: \test}
  $routeProvider.when '/:artifact',                         {templateUrl: partial-path(\artifact),       controller: \artifact}

CO2R.config [\$locationProvider, ($location-provider)->
  $location-provider.html5Mode on
]
