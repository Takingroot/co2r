# http://brunch.readthedocs.org/en/latest/config.html
exports.config =

  paths:
    public: '.public'

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
    stylesheets:
      join-to:
        'stylesheets/app.css': /^(app|vendor)/

    templates:
      join-to: 'javascripts/.not-needed-templates.js'

  plugins:
    stylus: (stylus)->
      stylus.import 'app/styles/prelude'
