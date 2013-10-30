window.co2r = angular.module(\co2r, [
  \ngSanitize
  \ui
  \bindCompile
  \Scope.onReady
  \carousel
  require \angular-escape
])



co2r.config ($route-provider, template-view, $location-provider)->

  $location-provider.html5-mode on

  $route-provider.when '/',
    redirect-to: '/directory'

  $route-provider.when '/directory',
    template-url: template-view(\directory)
    controller: \directory
    resolve:
      artifactsRes: (co2r-api)->
        co2r-api.get \artifacts, { cache:yes }

  $route-provider.when '/mission',
    template-url: template-view(\mission)
    controller: \mission

  $route-provider.when '/faq',
    template-url: template-view(\faq)
    controller: \faq
    reload-on-search: no
    resolve:
      faqRes: (co2r-api)->
        co2r-api.get \faqs, { cache:on }

  $route-provider.when '/register-your-product',
    template-url: template-view(\register)
    controller: \register

  $route-provider.when '/participate',
    template-url: template-view(\participate)
    controller: \participate

  $route-provider.when '/docs',
    template-url: template-view(\docs)
    controller: \docs


  # Every other route is assumed to be an artifact

  $route-provider.when '/:artifact',
    template-url: template-view(\artifact)
    controller: \artifact
