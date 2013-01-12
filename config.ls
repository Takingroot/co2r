# http://brunch.readthedocs.org/en/latest/config.html
exports.config =

  server:
    port: 9898

  paths:
    public: '.public'

  modules:
    wrapper: (path, data)-> "(function(){#data})();"
    definition: off

  files:
    javascripts:
      join-to:
        'javascripts/app.js': /^app\/scripts/
        'components/app-components.js': /(^app\/components)(?!.*-spec)/
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
        'components/app-components.css': /^app\/components/
        'stylesheets/vendor.css'       : /^vendor/
        'stylesheets/app.css'          : /^app\/(?!components)/

    templates:
      join-to: 'javascripts/.not-needed-templates.js'

  plugins:
    stylus: (stylus)->

      stylus.use require 'padding-classes-stylus'
      stylus.use require 'better-clockhand-stylus'
      components-path = 'app/components'

      stylus.import 'better-clockhand'
      stylus.import components-path + '/scale.styl'
      stylus.import components-path + '/base'
      stylus.import components-path + '/layout'
      stylus.import components-path + '/grid'


      stylus.import 'app/styles/lib/variables'
      stylus.import 'app/styles/variables'
      stylus.import 'app/styles/lib/functions'
