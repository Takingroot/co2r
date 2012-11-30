# http://brunch.readthedocs.org/en/latest/config.html
exports.config =

  paths:
    public: '.public'

  modules:
    wrapper: off
    definition: off

  files:
    javascripts:
      join-to:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
      order:
        before:
          'vendor/jquery.js'
          'vendor/angular.js'
          'vendor/underscore.js'
          'vendor/underscore.string.js'
          'scripts/co2r.ls'
    stylesheets:
      join-to:
        'stylesheets/app.css': /^(app|vendor)/

    templates:
      join-to: 'javascripts/.not-needed-templates.js'

  plugins:
    stylus: (stylus)->

      stylus.import 'vendor/kuhrt/css/base'
      stylus.import 'vendor/kuhrt/css/grid'


      stylus.import 'app/styles/app-lib/variables'
      stylus.import 'app/styles/app-lib/functions'

