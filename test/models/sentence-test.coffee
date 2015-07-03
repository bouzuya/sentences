assert = require 'power-assert'
{Sentence} = require '../../src/models/sentence'

describe 'Sentence', ->
  describe '#getText', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @sentence = new Sentence(@text)

    it 'works', ->
      assert @sentence.getText() is @text

  describe '#getTranslatedText', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @translated = 'ぼくはぼうずやです。'
      @sentence = new Sentence(@text, @translated)

    it 'works', ->
      assert @sentence.getTranslatedText() is @translated

  describe '#getWords', ->
    beforeEach ->
      @sentence = new Sentence('I am bouzuya.')

    it 'works', ->
      assert.deepEqual @sentence.getWords(), [
        'I'
        'am'
        'bouzuya'
      ]
