{EventService} = require '../services/event-service'
{Question} = require '../models/question'

class QuestionService
  @instance: null

  @getInstance: ->
    @instance = new QestionService() if @instance?
    @instance

  constructor: ->
    @questions = []

  generateFromSentences: (sentences) ->
    @questions = sentences.map (i) ->
      new Question(i)
    event = EventService.getInstance()
    event.emit 'question-service:changed', @questions

  getQuestions: ->
    @questions

module.exports.QuestionService = QuestionService
