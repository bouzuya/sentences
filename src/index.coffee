require 'angular'

angular
.module 'app', [
  require('./templates').name
]
.directive 'stApp', require './elements/st-app'
.directive 'stQuestion', require './elements/st-question'
.directive 'stQuestionList', require './elements/st-question-list'
.directive 'stSentence', require './elements/st-sentence'
.directive 'stSentenceList', require './elements/st-sentence-list'
