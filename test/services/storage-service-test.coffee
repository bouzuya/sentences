assert = require 'power-assert'
sinon = require 'sinon'
{EventService} = require '../../src/services/event-service'
{StorageService} = require '../../src/services/storage-service'

describe 'StorageService', ->
  beforeEach ->
    @sinon = sinon.sandbox.create()
    @jsonString =
      JSON.stringify
        version: '0.0.0'
        sentences: [
          text: 'text 1'
          translatedText: 'translated 1'
        ]

  afterEach ->
    @sinon.restore()

  describe '.getInstance', ->
    it 'works', ->
      service1 = StorageService.getInstance()
      service2 = StorageService.getInstance()
      assert service1
      assert service1 is service2

  describe '#load', ->
    beforeEach ->
      @sinon = sinon.sandbox.create()
      @originalWindow = global.window
      localStorage = getItem: ->
      @getItem = @sinon.stub localStorage, 'getItem', => @jsonString
      global.window = { localStorage }
      @event = EventService.getInstance()

    afterEach ->
      global.window = @originalWindow
      @event.removeAllListeners()

    it 'works', (done) ->
      @event.on 'storage-service:loaded', (data) =>
        assert @getItem.callCount is 1
        assert data is @jsonString
        done()
      service = new StorageService()
      service.load()

  describe '#save', ->
    beforeEach ->
      @originalWindow = global.window
      localStorage = setItem: ->
      @setItem = @sinon.stub localStorage, 'setItem', ->
      global.window = { localStorage }
      @event = EventService.getInstance()

    afterEach ->
      global.window = @originalWindow
      @event.removeAllListeners()

    it 'works', (done) ->
      @event.on 'storage-service:saved', =>
        assert @setItem.callCount is 1
        assert.deepEqual @setItem.getCall(0).args, [
          'sentences'
          @jsonString
        ]
        done()
      service = new StorageService()
      service.save @jsonString
