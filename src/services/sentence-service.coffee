{EventService} = require '../services/event-service'
{Sentence} = require '../models/sentence'

class SentenceService
  @instance: null

  @getInstance: ->
    @instance = new SentenceService() unless @instance?
    @instance

  constructor: ->
    @sentences = []

  addSentence: (text, translatedText) ->
    sentence = new Sentence(text, translatedText)
    @sentences.push sentence
    service = EventService.getInstance()
    service.emit 'sentence-service:changed', @sentences

  getSentences: ->
    @sentences

module.exports.SentenceService = SentenceService
