


###
TODO
  remove appjs
  clarify component(1) integration and build steps
###



module.exports = (grunt)->

  grunt.registerTask 'default', ['dev']
  grunt.registerTask 'dev'    , ['build', 'boot', 'watch']
  grunt.registerTask 'build'  , ['stylus', 'jade', 'livescript', 'concat', 'copy']
  grunt.registerTask 'boot'   , ['connect', 'open:dev']
  grunt.registerTask 'connect', 'Boot a server', ->
    require './.launch-production-server'



  grunt.initConfig

    watch:
      templates:
        files: ['app/**/*.jade']
        tasks: ['jade']
      styles:
        files: ['app/**/*.styl',]
        tasks: ['stylus']
      scripts:
        files: ['app/**/*.ls']
        tasks: ['livescript']
      scriptsjs:
        files: ['app/**/*.js']
        tasks: ['concat:appJs']

    open:
      dev:
        url: "http://localhost:9898"

    concat:
      vendorJs:
        files:
          '.public/javascripts/vendor.js': [
            'vendor/jquery.js'
            'vendor/angular.js'
            'vendor/underscore.js'
            'vendor/underscore.string.js'
            'vendor/**/*.js'
          ]
      vendorCss:
        files:
          '.public/styles/vendor.css': ['vendor/**/*.css']
      appJs:
        files:
          '.public/javascripts/appjs.js': ['app/**/*.js', '!app/**/*-spec.js', '!app/assets/**']

    copy:
      assets:
        options:
          destFilter: (dest)->
            dest.replace(/app\/assets(\/?)/g,'')
        files: [".public/": ['app/assets/**']]

    livescript: compile:
      files:
        '.public/javascripts/app.js': ['app/scripts/co2r.ls', 'app/**/*.ls']

    jade: compile:
      files:
        '.public/index.html': ['app/views/app/index.jade']
        '.public/views/'    : [ 'app/views/**/*.jade', '!app/views/app/index.jade' ]

    stylus: compile:
      files:
        '.public/styles/app.css': ['app/components/index.styl', 'app/views/**/*.styl']
      options:
        paths: ['app/components']
        use: [require('shorthand-edge-omissions-stylus')]
        import: [
          'shorthand-edge-omissions'
          'prelude'
          'media'
          'colors'
          'layout/functions'
          'grid/lib'
          'scale'
        ]



  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-open'
  grunt.loadNpmTasks 'grunt-contrib-watch'



  grunt.registerMultiTask 'jade', 'Compile jade to html', ->
    jade = require('jade')
    path = require('path')

    write = (filePath, fileContent)->
      grunt.log.writeln 'File ' + filePath.cyan + ' created.'
      grunt.file.write filePath, fileContent

    compile = (pathFile)->
      try
        (jade.compile (grunt.file.read pathFile), {filename: pathFile})() # No locals
      catch e
        grunt.log.error e
        grunt.fail.warn 'Jade failed to compile.'

    this.files.forEach (fileSeries, n)->
      fileSeries.src.forEach (filePath)->
        destBaseFilePath = path.normalize fileSeries.dest

        # TODO Docs

        if path.extname destBaseFilePath
          write destBaseFilePath, compile(filePath)
        else
          destFileName     = path.dirname(filePath).split(path.sep)[2] + '.html'
          destFilePath     = destBaseFilePath + destFileName

          write destFilePath, compile(filePath)







  grunt.registerMultiTask 'livescript', 'Compile livescript to js', ->
    path = require('path')
    ls   = require('LiveScript')

    grunt.util.async.forEachSeries this.files, (f,n)->
      destFile = path.normalize f.dest
      compiled = []


      compile = (filePath, next)->
        lsCode = grunt.file.read filePath
        try
          lsOut = ls.compile lsCode
          compiled.push lsOut
          next null
        catch e
          grunt.log.error e
          grunt.fail.warn 'LiveScript failed to compile.'

      write = ->
        grunt.file.write(destFile, compiled.join(grunt.util.normalizelf(grunt.util.linefeed)))
        grunt.log.writeln('File ' + destFile.cyan + ' created.')

      grunt.util.async.concatSeries f.src, compile, write
