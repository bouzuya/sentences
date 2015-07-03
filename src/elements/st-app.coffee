{Sentence} = require '../models/sentence'

class Controller
  constructor: ->
    @sentence = null
    @translated = null
    @sentences = [
      new Sentence('This is a pen.', 'これはペンです。')
    ,
      new Sentence('That is two bananas.', 'あれは2本のバナナです。')
    ]

  add: ->
    @sentences.push new Sentence(@sentence, @translated)
    @sentence = null
    @translated = null

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  templateUrl: '/elements/st-app.html'
