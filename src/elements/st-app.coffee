{Sentence} = require '../models/sentence'

class Controller
  constructor: ->
    @sentence = null
    @sentences = [
      new Sentence('This is a pen.')
    ,
      new Sentence('That is two bananas.')
    ]

  add: ->
    @sentences.push new Sentence(@sentence)
    @sentence = null

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  templateUrl: '/elements/st-app.html'
