


window.co2r =
  services:    angular.module \co2r.services, []
  filters:     angular.module \co2r.filters, []
  directives:  angular.module \co2r.directives, []
  controllers: angular.module \co2r.controllers , []
  app:         angular.module \co2r, [
                \ngSanitize
                \ui
                \bindCompile
                \Scope.onReady
                \co2r.services
                \co2r.filters
                \co2r.controllers
                \co2r.directives
                ]



co2r.app.config ($route-provider, template-view, $location-provider)->
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

  $route-provider.when '/register-your-product',
    template-url: template-view(\register)
    controller: \register

  $route-provider.when '/participate',
    template-url: template-view(\participate)
    controller: \participate

  $route-provider.when '/:artifact',
    template-url: template-view(\artifact)
    controller: \artifact
