class Controller

module.exports = ->
  bindToController: true
  controller: Controller
  controllerAs: 'c'
  restrict: 'E'
  scope:
    model: '='
  templateUrl: '/elements/st-sentence.html'
