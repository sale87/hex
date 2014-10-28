module.exports = function (grunt) {
  require('load-grunt-tasks')(grunt);

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    distdir: 'public',
    src: {
      app: 'client',
      fonts: ['assets/fonts'],
      js: ['<%= src.app %>/**/*.js'],
      index: ['<%= src.app %>/index.html'],
      html: ['<%= src.app %>/**/*.html'],
      css: ['<%= src.app %>/assets/css/bootstrap.min.css', '<%= src.app %>/assets/css/style.css'],
      config: ['config/config.js']
    },
    concat: {
      options: {
        separator: ';'
      },
      dist: {
        src: ['<%= src.app %>/app.js', '<%= src.js %>'],
        dest: '<%= distdir %>/js/<%= pkg.name %>.js'
      },
      index: {
        src: ['<%= src.index %>'],
        dest: '<%= distdir %>/index.html',
        options: {
          process: true
        }
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      },
      dist: {
        files: {
          '<%= distdir %>/js/<%= pkg.name %>.js': ['<%= concat.dist.dest %>']
        }
      },
      bower: {
        options: {
          mangle: true,
          compress: true
        },
        files: {
          '<%= distdir %>/js/vendor.js': '<%= distdir %>/js/vendor.js'
        }
      }
    },
    bower_concat: {
      all: {
        dest: '<%= distdir %>/js/vendor.js'
      }
    },
    clean: ['<%= distdir %>/*'],
    cssmin: {
      combine: {
        files: {
          '<%= distdir %>/assets/css/style.css': ['<%= src.css %>']
        }
      }
    },
    copy: {
      html: {
        expand: true,
        cwd: '<%= src.app %>',
        src: '*/*.html',
        dest: '<%= distdir %>/views/',
        filter: 'isFile'
      },
      assets: {
        expand: true,
        cwd: '<%= src.app%>/<%= src.fonts %>',
        src: '*',
        dest: '<%= distdir %>/<%= src.fonts %>/',
        flatten: true,
        filter: 'isFile'
      },
      config: {
        src: '<%= src.config %>',
        dest: '<%= distdir %>/js/',
        flatten: true,
        filter: 'isFile',
        expand: true
      }
    },
    watch: {
      default: {
        files: ['<%= src.js %>', '<%= src.index %>', '<%= src.html %>', '<%= src.config %>'],
        tasks: ['build-dev']
      }
    }
  });

  grunt.registerTask('default', ['clean', 'concat', 'bower_concat', 'uglify', 'cssmin', 'copy']);
  grunt.registerTask('build-dev', ['clean', 'concat', 'bower_concat', 'cssmin', 'copy']);
  grunt.registerTask('build', ['default']);
};
