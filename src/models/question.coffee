shuffle = require 'lodash.shuffle'

class Question
  constructor: (@sentence) ->
    @shuffled = shuffle @sentence.getWords()

  getSentence: ->
    @sentence

  getText: ->
    @shuffled.join(' ') + '.'

  getWords: ->
    @shuffled

module.exports.Question = Question
