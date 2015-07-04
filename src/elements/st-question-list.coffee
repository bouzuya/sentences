{EventService} = require '../services/event-service'
{QuestionService} = require '../services/question-service'

class Controller
  @$inject: [
    '$timeout'
  ]

  constructor: (@$timeout) ->
    event = EventService.getInstance()
    @answers = [] # Array<{ text: String, isCorrect: boolean? }>
    event.on 'question-service:changed', (questions) =>
      @answers = questions.map (i) ->
        text: null
        isCorrect: null

  answer: (index) ->
    service = QuestionService.getInstance()
    questions = service.getQuestions()
    question = questions[index]
    answer = @answers[index]
    answer.isCorrect = question.answer answer.text
    @$timeout ->

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope:
    model: '='
  templateUrl: '/elements/st-question-list.html'
