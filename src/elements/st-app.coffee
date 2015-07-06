{EventService} = require '../services/event-service'
{QuestionService} = require '../services/question-service'
{Sentence} = require '../models/sentence'
{SentenceService} = require '../services/sentence-service'
{StorageService} = require '../services/storage-service'

class Controller
  @$inject: [
    '$timeout'
  ]

  constructor: (@$timeout) ->
    event = EventService.getInstance()
    service = SentenceService.getInstance()
    storage = StorageService.getInstance()

    event.on 'question-service:changed', (questions) =>
      @$timeout => @questions = questions

    event.on 'sentence-service:changed', (sentences) =>
      # FIXME:
      storage.save service.exportSentences()
      @$timeout => @sentences = sentences

    event.on 'storage-service:loaded', (json) =>
      service.importSentences json
      @$timeout ->

    event.on 'storage-service:saved', ->
      console.log 'saved!'

    @exported = null
    @json = null
    @text = null
    @translated = null
    @questions = [] # Array<Question>
    @sentences = [] # Array<Sentence>

    storage.load()

  add: ->
    service = SentenceService.getInstance()
    service.addSentence(@text, @translated)
    @text = null
    @translated = null

  export: ->
    service = SentenceService.getInstance()
    @exported = service.exportSentences()

  generateQuestions: (sentence) ->
    service = QuestionService.getInstance()
    service.generateFromSentences @sentences

  import: ->
    service = SentenceService.getInstance()
    service.importSentences @json
    @json = null

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  templateUrl: '/elements/st-app.html'
