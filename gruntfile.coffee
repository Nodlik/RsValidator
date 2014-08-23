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
      dist:
        options:
          baseUrl: 'src/js'
          out: 'build/js/main.js'
          mainConfigFile: 'src/js/config.js'
          optimize: 'none'
          name: 'almond',
          removeCombined: true
          almond: true,
          include: ['config'],
          insertRequire: ['config'],
          wrap:
            startFile: "src/js/intro.frag",
            endFile: "src/js/outro.frag"

    clean:
      build:
        src: ["build"]
      js:
        src: ["src/js/*", "!src/js/packages/**", "!src/js/test.js", "!src/js/test/**", "!src/js/intro.frag", "!src/js/outro.frag", "!src/js/almond.js"]
      requirejs:
        src: ["build/js/require.js"]

    uglify:
      dist:
        files: {
          'build/js/main.js': [
            #'build/js/require.js'
            'build/js/main.js'
          ]
        }

    copy:
      requirejs:
        files: [
          {src: ['src/js/packages/requirejs/require.js'], dest: 'build/js/require.js'},
        ]
      images:
        files: [
          {expand: true, cwd: 'src/images/', src: ['**'], dest: 'build/images/'},
        ]

  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'build-coffee', ['requirejs:dev']

  grunt.registerTask('default', [
    'clean'
    'requirejs:dev'
    'less'
    'copy'
    'watch'
  ])

  grunt.registerTask('build', [
    'clean:build'
    'clean:js'
    'coffee'
    'requirejs:dist'
    'copy'
    #'uglify'
    #'clean:requirejs'
  ])