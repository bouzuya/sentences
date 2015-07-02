require 'angular'

angular
.module 'app', [
  require('./templates').name
]
.directive 'stApp', require './elements/st-app'
.directive 'stSentence', require './elements/st-sentence'
.directive 'stSentenceList', require './elements/st-sentence-list'
