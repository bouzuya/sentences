require 'angular'

angular
.module 'app', [
  require('./templates').name
]
.directive 'stApp', require './elements/st-app'
