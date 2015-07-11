{EventService} = require '../services/event-service'
{Question} = require '../models/question'

class QuestionService
  @instance: null

  @getInstance: ->
    @instance = new QuestionService() unless @instance?
    @instance

  constructor: ->
    @questions = []
    @selectedQuestion = null

  generateFromSentences: (sentences) ->
    @questions = sentences.map (i) ->
      new Question(i)
    event = EventService.getInstance()
    event.emit 'question-service:changed', @questions

  getQuestions: ->
    @questions

  isSelectedQuestion: (question) ->
    @selectedQuestion is question

  selectQuestion: (question) ->
    @selectedQuestion = question

module.exports.QuestionService = QuestionService
