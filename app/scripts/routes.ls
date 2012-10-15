CO2R.config [\$routeProvider, ($routeProvider)->
  $routeProvider.when '/',                                  {templateUrl: app_data.partial-path('directory'),      controller: \directory}
  $routeProvider.when '/directory',                         {templateUrl: app_data.partial-path('directory'),      controller: \directory}
  $routeProvider.when '/about',                             {templateUrl: app_data.partial-path('about'),          controller: \about}
  $routeProvider.when '/faq',                               {templateUrl: app_data.partial-path('faq'),            controller: \faq}
  $routeProvider.when '/register-your-product',             {templateUrl: app_data.partial-path('register'),       controller: \register}
  $routeProvider.when '/other-things-you-can-do-to-help',   {templateUrl: app_data.partial-path('other_things'),   controller: \other-things}
  $routeProvider.when '/test',                              {templateUrl: app_data.partial-path('test'),           controller: \test}
  $routeProvider.when '/:artifact',                         {templateUrl: app_data.partial-path('artifact'),       controller: \artifact}
]
