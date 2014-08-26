module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'src/js/'
        ext: '.js'

    watch:
      coffeescript:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee']

    requirejs:
      prod:
        options:
          baseUrl: 'src/js'
          out: 'build/rsvalidator.js'
          optimize: 'none'
          name: 'almond',
          removeCombined: true
          almond: true,
          include: ['rs-validator'],
          insertRequire: ['rs-validator'],
          wrap:
            startFile: "src/js/intro.frag",
            endFile: "src/js/outro.frag"
      test:
        options:
          baseUrl: 'src/js'
          out: 'build/rsvalidator-tests.js'
          mainConfigFile: 'src/js/test.js'
          optimize: 'none'
          name: 'almond',
          removeCombined: true
          almond: true,
          include: ['test'],
          insertRequire: ['test'],
          wrap:
            startFile: "src/js/intro.frag",
            endFile: "src/js/outro.frag"

    clean:
      build:
        src: ["build"]
      js:
        src: ["src/js/*", "!src/js/packages/**", "!src/js/test.js", "!src/js/test/**", "!src/js/intro.frag", "!src/js/outro.frag", "!src/js/almond.js"]

    uglify:
      dist:
        files: {
          'build/rsvalidator.js': [
            'build/rsvalidator.js'
          ]
        }

  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'


  grunt.registerTask('build', [
    'clean:build'
    'clean:js'
    'coffee'
    'requirejs:prod'
    'uglify'
  ])

  grunt.registerTask('build:test', [
    'clean:build'
    'clean:js'
    'coffee'
    'requirejs:test'
    'uglify'
  ])