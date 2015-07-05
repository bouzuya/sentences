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
    event = EventService.getInstance()
    event.emit 'sentence-service:changed', @sentences

  getSentences: ->
    @sentences

  importSentences: (jsonString) ->
    json = JSON.parse jsonString
    @sentences = json.sentences.map ({ text, translatedText }) ->
      new Sentence(text, translatedText)
    event = EventService.getInstance()
    event.emit 'sentence-service:changed', @sentences

module.exports.SentenceService = SentenceService
