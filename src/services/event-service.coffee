{EventEmitter} = require 'events'

class EventService extends EventEmitter
  @instance: null

  @getInstance: ->
    @instance = new EventService() unless @instance?
    @instance

module.exports.EventService = EventService
