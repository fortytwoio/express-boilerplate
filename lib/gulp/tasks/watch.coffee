module.exports = () ->
  gulp.watch "public/less/**/*.less", ["less"]
  gulp.watch "public/img/**/*.*", ["images"]

  config.isWatching = true
