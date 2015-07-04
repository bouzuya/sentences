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
      @$timeout => @questions = questions

    event.on 'sentence-service:changed', (sentences) =>
      @$timeout => @sentences = sentences

    @text = null
    @translated = null
    @questions = [] # Array<Question>
    @sentences = [] # Array<Sentence>

    # add some dummy data
    service.addSentence('This is a pen.', 'これはペンです。')
    service.addSentence('He is bouzuya.', '彼はぼうずやです。')
    service.addSentence('Cute is justice', 'かわいいは正義')

  add: ->
    service = SentenceService.getInstance()
    service.addSentence(@text, @translated)
    @text = null
    @translated = null

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
