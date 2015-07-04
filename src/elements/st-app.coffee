{EventService} = require '../services/event-service'
{QuestionService} = require '../services/question-service'
{Sentence} = require '../models/sentence'
{SentenceService} = require '../services/sentence-service'

class Controller
  @$inject: [
    '$timeout'
  ]

  constructor: (@$timeout) ->
    event = EventService.getInstance()
    service = SentenceService.getInstance()

    event.on 'question-service:changed', (questions) =>
      @$timeout =>
        @questions = questions
        @answers = questions.map (i) ->
          text: null
          isCorrect: null

    event.on 'sentence-service:changed', (sentences) =>
      @$timeout => @sentences = sentences

    @text = null
    @translated = null
    @answers = [] # Array<{ text: String, isCorrect: boolean? }>
    @questions = [] # Array<Question>
    @sentences = [] # Array<Sentence>

    # add some dummy data
    service.addSentence('This is a pen.', 'これはペンです。')
    service.addSentence('That is two bananas.', 'あれは2本のバナナです。')

  add: ->
    service = SentenceService.getInstance()
    service.addSentence(@text, @translated)
    @text = null
    @translated = null

  answer: (index) ->
    question = @questions[index]
    answer = @answers[index]
    answer.isCorrect = question.answer answer.text
    @$timeout ->

  generateQuestions: (sentence) ->
    service = QuestionService.getInstance()
    service.generateFromSentences @sentences

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  templateUrl: '/elements/st-app.html'
