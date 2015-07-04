{EventService} = require '../services/event-service'
{QuestionService} = require '../services/question-service'

class Controller
  @$inject: [
    '$timeout'
  ]

  constructor: (@$timeout) ->
    event = EventService.getInstance()
    @answers = []
    event.on 'question-service:changed', (questions) =>
      @answers = questions.map (i) ->
        isCorrect: null
        question: i
        words: i.getWords().map (text, index) ->
          { index, text, selectedIndex: null }
      @$timeout ->

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope:
    model: '='
  templateUrl: '/elements/st-question-list.html'
