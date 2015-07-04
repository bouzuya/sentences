{EventService} = require '../services/event-service'
{QuestionService} = require '../services/question-service'

class Controller
  @$inject: [
    '$timeout'
  ]

  constructor: (@$timeout) ->

  getSelectedWords: ->
    selectedWords = @answer.words.filter (i) -> i.selectedIndex?
    selectedWords.sort (a, b) ->
      return 0 if a.selectedIndex is b.selectedIndex
      if a.selectedIndex < b.selectedIndex then -1 else 1

  selectWord: (word) ->
    # select word
    word.selectedIndex = @getSelectedWords().length + 1
    # answer if select all words
    if @answer.question.getWords().length is @getSelectedWords().length
      answerText = @getSelectedWords().map((i) -> i.text).join(' ') + '.'
      @answer.isCorrect = @answer.question.answer answerText
    @$timeout ->

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope:
    answer: '='
  templateUrl: '/elements/st-answer.html'
