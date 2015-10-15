module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg     : grunt.file.readJSON('package.json') ,

    haml  : {
      dist  : {
        files   : {
          'index.html' : 'source/haml/index.haml'   , 
          'places.html': 'source/haml/places.haml' ,
          'about.html' : 'source/haml/about.haml' ,
          'login.html' : 'source/haml/login.haml' ,
          'login.html' : 'source/haml/menu.haml'
        }
      }
    } ,

    watch : {
      coffee : {
        files : 'source/coffee/**/*.coffee' ,
        tasks : ['coffee']
      } ,

      haml  : {
        files : 'source/haml/**/*.haml' ,
        tasks : ['haml']
      }
    } ,

    coffee  : {
      options : {
        bare : true
      } ,

      build : {
        expand  : true                  , 
        cwd     : 'source/coffee'              ,
        src     : '**/*.coffee'  ,
        dest    : 'src'                 ,
        ext     : '.js'
      }
    }

  });

  grunt.loadNpmTasks( 'grunt-haml2html' );
  grunt.loadNpmTasks( 'grunt-contrib-coffee' );
  grunt.loadNpmTasks( 'grunt-contrib-watch' );
  
  grunt.registerTask( 'default', ['haml' , 'coffee' , 'watch'] );

};