gulp.task "watch", [ "coffeelint", "test", "setwatch", "build", "watch:less", "watch:css", "watch:img", "watch:js",
    "watch:jade", "watch:public", "watch:tests", "watch:coffee" ]
