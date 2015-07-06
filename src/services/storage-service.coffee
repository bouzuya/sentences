{EventService} = require '../services/event-service'

class StorageService
  @instance: null

  @getInstance: ->
    @instance = new StorageService() unless @instance?
    @instance

  load: ->
    localStorage = window.localStorage
    return unless localStorage?
    loaded = localStorage.getItem 'sentences'
    return unless loaded?
    event = EventService.getInstance()
    event.emit 'storage-service:loaded', loaded

  save: (data) ->
    localStorage = window.localStorage
    return unless localStorage?
    localStorage.setItem 'sentences', data
    event = EventService.getInstance()
    event.emit 'storage-service:saved'

module.exports.StorageService = StorageService
