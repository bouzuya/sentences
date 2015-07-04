{EventService} = require '../services/event-service'
{QuestionService} = require '../services/question-service'
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
    @questions = []
    @sentences = []

    # add some dummy data
    service.addSentence('This is a pen.', 'これはペンです。')
    service.addSentence('That is two bananas.', 'あれは2本のバナナです。')

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
