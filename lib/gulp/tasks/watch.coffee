module.exports = () ->
  gulp.watch "./webapps/**/public/coffee/**/*.coffee", ["browserify"]
  gulp.watch "./webapps/**/public/less/**/*.less", ["less"]
  gulp.watch "./webapps/**/public/img/**/*.*", ["images"]
