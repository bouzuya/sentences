browserify = require 'browserify'
browserSync = require 'browser-sync'
buffer = require 'vinyl-buffer'
coffee = require 'gulp-coffee'
del = require 'del'
espower = require 'gulp-espower'
gulp = require 'gulp'
gutil = require 'gulp-util'
mocha = require 'gulp-mocha'
run = require 'run-sequence'
source = require 'vinyl-source-stream'
sourcemaps = require 'gulp-sourcemaps'
uglify = require 'gulp-uglify'
watch = require 'gulp-watch'
watchify = require 'watchify'

ignoreError = (stream) ->
  stream.on 'error', (e) ->
    gutil.log e
    @emit 'end'

gulp.task 'build', (done) ->
  run 'build:coffee', 'build:js', done

gulp.task 'build(dev)', (done) ->
  run 'build:coffee(dev)', 'build:js(dev)', done

gulp.task 'build:coffee', ->
  gulp.src './src/**/*.coffee'
  .pipe coffee()
  .pipe gulp.dest './.tmp/src/'

gulp.task 'build:coffee(dev)', ->
  gulp.src './src/**/*.coffee'
  .pipe sourcemaps.init()
  .pipe ignoreError coffee()
  .pipe sourcemaps.write()
  .pipe gulp.dest './.tmp/src/'

gulp.task 'build:js', ->
  b = browserify
    entries: ['./.tmp/src/index.js']
    debug: false
  b.bundle()
  .pipe source 'bundle.js'
  .pipe buffer()
  .pipe uglify()
  .pipe gulp.dest './lib/'

gulp.task 'build:js(dev)', ->
  b = browserify
    entries: ['./.tmp/src/index.js']
    debug: true
  b.bundle()
  .pipe source 'bundle.js'
  .pipe buffer()
  .pipe sourcemaps.init loadMaps: true
  .pipe sourcemaps.write './'
  .pipe gulp.dest './lib/'

gulp.task 'build-test', ->
  gulp.src './test/**/*.coffee'
  .pipe sourcemaps.init()
  .pipe coffee()
  .pipe espower()
  .pipe sourcemaps.write()
  .pipe gulp.dest './.tmp/test/'

gulp.task 'build-test(dev)', ->
  gulp.src './test/**/*.coffee'
  .pipe sourcemaps.init()
  .pipe ignoreError coffee()
  .pipe ignoreError espower()
  .pipe sourcemaps.write()
  .pipe gulp.dest './.tmp/test/'

gulp.task 'clean', (done) ->
  del [
    './.tmp/'
    './lib/'
  ], done
  null

gulp.task 'default', (done) ->
  run.apply run, [
    'clean'
    'build'
    done
  ]
  null

gulp.task 'test', ['build', 'build-test'], ->
  gulp.src './.tmp/test/**/*.js'
  .pipe mocha()

gulp.task 'test(dev)', ['build-test(dev)'], ->
  gulp.src './.tmp/test/**/*.js'
  .pipe ignoreError mocha()

gulp.task 'watch', ['build(dev)'], ->
  watch [
    './src/**/*.coffee'
    './test/**/*.coffee'
  ], ->
    run.apply run, [
      'build:coffee(dev)'
      'test(dev)'
      ->
    ]

  browserSync
    server:
      baseDir: './lib/'

  options =
    cache: {}
    packageCache: {}
    entries: ['./.tmp/src/index.js']
    debug: true
  b = browserify options
  w = watchify b

  bundle = ->
    w.bundle()
    .on 'error', gutil.log.bind(gutil)
    .pipe source 'bundle.js'
    .pipe buffer()
    .pipe sourcemaps.init loadMaps: true
    .pipe sourcemaps.write './'
    .pipe gulp.dest './lib/'
    browserSync.reload()

  w.on 'update', bundle
  w.on 'log', gutil.log.bind(gutil)
  bundle()
