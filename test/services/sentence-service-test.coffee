assert = require 'power-assert'
{EventService} = require '../../src/services/event-service'
{Sentence} = require '../../src/models/sentence'
{SentenceService} = require '../../src/services/sentence-service'

describe 'SentenceService', ->
  describe '.getInstance', ->
    it 'works', ->
      service1 = SentenceService.getInstance()
      service2 = SentenceService.getInstance()
      assert service1
      assert service1 is service2

  describe '#addSentence', ->
    beforeEach ->
      @event = EventService.getInstance()
      @service = new SentenceService()
      @text = 'I am bouzuya.'
      @translated = 'ぼくぼうずや'

    afterEach ->
      @event.removeAllListeners()

    it 'works', (done) ->
      @event.on 'sentence-service:changed', (sentences) =>
        assert.deepEqual sentences, [
          new Sentence(@text, @translated)
        ]
        done()
      @service.addSentence @text, @translated

  describe '#exportSentences', ->
    beforeEach ->
      @service = new SentenceService()
      @service.addSentence 'text 1', 'translated 1'
      @service.addSentence 'text 2', 'translated 2'

    it 'works', ->
      assert.deepEqual JSON.parse(@service.exportSentences()),
        version: '0.0.0'
        sentences: [
          text: 'text 1'
          translatedText: 'translated 1'
        ,
          text: 'text 2'
          translatedText: 'translated 2'
        ]

  describe '#getSentences', ->
    beforeEach ->
      @service = new SentenceService()
      @service.addSentence 'text 1', 'translated 1'
      @service.addSentence 'text 2', 'translated 2'

    it 'works', ->
      assert.deepEqual @service.getSentences(), [
        new Sentence('text 1', 'translated 1')
        new Sentence('text 2', 'translated 2')
      ]

  describe '#importSentences', ->
    beforeEach ->
      @event = EventService.getInstance()
      @service = new SentenceService()
      @text = 'I am bouzuya.'
      @translated = 'ぼくぼうずや'
      @json =
        sentences: [
          text: @text
          translatedText: @translated
        ]

    afterEach ->
      @event.removeAllListeners()

    it 'works', (done) ->
      @event.on 'sentence-service:changed', (sentences) =>
        assert.deepEqual sentences, [
          new Sentence(@text, @translated)
        ]
        done()
      @service.importSentences JSON.stringify @json
