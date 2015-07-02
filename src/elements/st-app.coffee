class Controller
  constructor: ->
    @sentence = null
    @sentences = [
      sentence: 'This is a pen.'
    ,
      sentence: 'That is two bananas.'
    ]

  add: ->
    @sentences.push sentence: @sentence
    @sentence = null

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  templateUrl: '/elements/st-app.html'
