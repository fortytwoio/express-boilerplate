gulp.task "watch", [ "setwatch", "build", "watch:less", "watch:css", "watch:img", "watch:js", "watch:jade",
    "watch:public", "watch:tests" ]

