assert = require 'power-assert'
{EventService} = require '../../src/services/event-service'
{Sentence} = require '../../src/models/sentence'
{QuestionService} = require '../../src/services/question-service'

describe 'QuestionService', ->
  describe '.getInstance', ->
    it 'works', ->
      service1 = QuestionService.getInstance()
      service2 = QuestionService.getInstance()
      assert service1
      assert service1 is service2

  describe '#generateFromSentences', ->
    beforeEach ->
      @event = EventService.getInstance()
      @service = new QuestionService()
      @sentences = [
        new Sentence('text 1', 'translated 1')
        new Sentence('text 2', 'translated 2')
      ]

    afterEach ->
      @event.removeAllListeners()

    it 'works', (done) ->
      @event.on 'question-service:changed', (questions) =>
        assert.deepEqual questions.map((i) -> i.getSentence()), @sentences
        done()
      @service.generateFromSentences @sentences

  describe '#isSelectedQuestion / #selectQuestion', ->
    beforeEach ->
      @event = EventService.getInstance()
      @service = new QuestionService()
      @sentences = [
        new Sentence('text 1', 'translated 1')
        new Sentence('text 2', 'translated 2')
      ]
      @service.generateFromSentences @sentences

    afterEach ->
      @event.removeAllListeners()

    it 'works', ->
      questions = @service.getQuestions()
      question = questions[0]
      assert !@service.isSelectedQuestion(question)
      @service.selectQuestion question
      assert @service.isSelectedQuestion(question)
