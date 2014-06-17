gulp.task "watch", [
    "setwatch",
    "build",
    "monitor",
    "watch:coffee",
    "watch:less",
    "watch:css",
    "watch:img",
    "watch:js"
]
