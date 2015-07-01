class Controller
  constructor: ->
    console.log 'OK'

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope: {}
  template: '<p>Hello, AngularJS</p>'
