module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg     : grunt.file.readJSON('package.json') ,

    connect: {
      server: {
        options: {
          port: 3777
        }
      }
    } ,

    haml  : {

      dist  : {
        files   : [
          { expand: true, cwd:'src', src: 'source/haml/**/*.haml', dest: 'src', ext : '.html' }
        ]
      } ,

      watch : {
        files : {}
      }

    } ,

    watch : {
      coffee : {
        files : 'source/coffee/**/*.coffee' ,
        tasks : ['coffee']
      } ,

      haml  : {
        files : 'source/haml/**/*.haml' ,
        tasks : ['haml:watch'] ,
        options: {
          spawn: false
        }
      } ,

      compass : {
        files : 'source/sass/**/*.sass' ,
        tasks : ['compass:dist']
      }
    } ,

    coffee  : {
      options : {
        bare : true
      } ,

      build : {
        expand  : true            , 
        cwd     : 'source/coffee' ,
        src     : '**/*.coffee'   ,
        dest    : 'src'           ,
        ext     : '.js'
      }
    } ,

    compass : {
      dist : {
        options : {          
          cssDir    : "src/css" ,
          sassDir   : "source/sass" ,
          imagesDir : "src/images"
        }
      }
    }

  });

  grunt.event.on('watch', function(action, filepath) {
    
    var replace , root;

    if(filepath.indexOf('.haml') === -1) return;

    var proto       = ( filepath.indexOf('design_prototypes') !== -1 ) ? true : false

    if ( filepath.indexOf( '/' ) !== -1 ){
      replace = (proto) ? 'source/haml/design_prototypes/'    : 'source/haml'
    } else {
      replace = (proto) ? 'source\\haml\\design_prototypes\\' : 'source\\haml'
    }

    root            = (proto) ? '' : 'src'
    
    var file        = {};    
    var destfile    = filepath.replace( '.haml','.html' );
    destfile        = destfile.replace(  replace , root );
    file[destfile]  = filepath;

    console.log('Parts: ' , replace , root);
    console.log('Compile file ' + filepath + ' to ' + destfile );
    
    grunt.config('haml.watch.files', file);
  });

  grunt.loadNpmTasks( 'grunt-haml2html'       );
  grunt.loadNpmTasks( 'grunt-contrib-coffee'  );
  grunt.loadNpmTasks( 'grunt-contrib-watch'   );
  grunt.loadNpmTasks( 'grunt-contrib-compass' );
  grunt.loadNpmTasks( 'grunt-contrib-connect' );
  
  grunt.registerTask( 'default', [ 'connect' , 'haml' , 'coffee' , 'watch'] );

};