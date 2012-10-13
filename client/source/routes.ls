
CO2R.config [\$routeProvider, ($routeProvider)->
  $routeProvider.when '/directory',                         {templateUrl: app_data.partial-path('directory'),      controller: controller_directory}
  $routeProvider.when '/',                                  {templateUrl: app_data.partial-path('directory'),      controller: controller_directory}
  $routeProvider.when '/about',                             {templateUrl: app_data.partial-path('about'),          controller: controller_about}
  $routeProvider.when '/faq',                               {templateUrl: app_data.partial-path('faq'),            controller: controller_faq}
  $routeProvider.when '/register-your-product',             {templateUrl: app_data.partial-path('register'),       controller: controller_register}
  $routeProvider.when '/other-things-you-can-do-to-help',   {templateUrl: app_data.partial-path('other_things'),   controller: controller_other_things}
  $routeProvider.when '/test',                              {templateUrl: app_data.partial-path('test')}
  $routeProvider.when '/:artifact',                         {templateUrl: app_data.partial-path('artifact'),       controller: controller_artifact}
]
