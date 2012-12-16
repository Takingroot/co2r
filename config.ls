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
        'components/components.css': /^app\/components/
        'stylesheets/vendor.css'   : /^vendor/
        'stylesheets/app.css'      : /^app\/(?!components)/

    templates:
      join-to: 'javascripts/.not-needed-templates.js'

  plugins:
    stylus: (stylus)->
      components-path = 'app/components'
      stylus.import components-path + '/base'
      stylus.import components-path + '/layout'
      stylus.import components-path + '/grid'


      stylus.import 'app/styles/lib/variables'
      stylus.import 'app/styles/lib/functions'

