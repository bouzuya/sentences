assert = require 'power-assert'
{EventService} = require '../../src/services/event-service'

describe 'EventService', ->
  describe '.getInstance', ->
    it 'works', ->
      service1 = EventService.getInstance()
      service2 = EventService.getInstance()
      assert service1 is service2

  describe '#emit & #on', ->
    beforeEach ->
      @service = EventService.getInstance()

    it 'works', (done) ->
      @service.on 'service:event-name', (obj) ->
        assert obj.key is 'value'
        done()
      @service.emit 'service:event-name', key: 'value'
