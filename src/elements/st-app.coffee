class Controller
  constructor: ->
    @message = 'Hello, AngularJS!'
    @sentences = [
      sentence: 'This is a pen.'
    ,
      sentence: 'That is two bananas.'
    ]

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  templateUrl: '/elements/st-app.html'
