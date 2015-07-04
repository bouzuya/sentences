shuffle = require 'lodash.shuffle'
{Sentence} = require '../models/sentence'

class Question
  constructor: (@sentence) ->
    @shuffled = shuffle @sentence.getWords()

  answer: (answerText) ->
    sentence = new Sentence(answerText, null)
    @sentence.getText() is sentence.getText()

  getSentence: ->
    @sentence

  getText: ->
    @shuffled.join(' ') + '.'

  getWords: ->
    @shuffled

module.exports.Question = Question
