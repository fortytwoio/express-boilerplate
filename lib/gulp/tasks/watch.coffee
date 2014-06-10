gulp.task "watch", [ "build", "setwatch", "monitor"], ()->
  # do not use path starting with './' when you also use file globs. Does not work correctly
  gulp.watch "webapps/**/public/less/**/*.less", ["less"]
  gulp.watch "webapps/**/public/img/**/*", ["images"]
  gulp.watch "webapps/**/public/css/**/*", ["copy"]
