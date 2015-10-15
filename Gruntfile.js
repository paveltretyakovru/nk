//'index.html' : 'source/haml/index.haml'   , 
//'places.html': 'source/haml/places.haml'  ,
//'about.html' : 'source/haml/about.haml'   ,
//'login.html' : 'source/haml/login.haml'   ,

//'index.html' : 'source/haml/index.haml'   , 
//'places.html': 'source/haml/places.haml'  ,
//'about.html' : 'source/haml/about.haml'   ,
//'login.html' : 'source/haml/login.haml'   ,

//'index.html' : 'source/haml/index.haml'   , 
//'places.html': 'source/haml/places.haml'  ,
//'about.html' : 'source/haml/about.haml'   ,
//'login.html' : 'source/haml/login.haml'   ,

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg     : grunt.file.readJSON('package.json') ,

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

  grunt.event.on('watch', function(action, filepath) {
    if(filepath.indexOf('.haml') === -1) return;

    var proto       = ( filepath.indexOf('design_prototypes') !== -1 ) ? true : false
    var replace     = (proto) ? 'source\\haml\\design_prototypes\\' : 'source\\haml'
    var root        = (proto) ? '' : 'src'

    
    var file        = {};    
    var destfile    = filepath.replace( '.haml','.html' );
    destfile        = destfile.replace(  replace , root );
    file[destfile]  = filepath;

    console.log('Compile file ' + filepath + ' to ' + destfile );
    
    grunt.config('haml.watch.files', file);
  });

  grunt.loadNpmTasks( 'grunt-haml2html'       );
  grunt.loadNpmTasks( 'grunt-contrib-coffee'  );
  grunt.loadNpmTasks( 'grunt-contrib-watch'   );
  
  grunt.registerTask( 'default', ['haml' , 'coffee' , 'watch'] );

};