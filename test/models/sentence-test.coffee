assert = require 'power-assert'
{Sentence} = require '../../src/models/sentence'

describe 'Sentence', ->
  describe '#getText', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @sentence = new Sentence(@text)

    it 'works', ->
      assert @sentence.getText() is @text

  describe '#getWords', ->
    beforeEach ->
      @sentence = new Sentence('I am bouzuya.')

    it 'works', ->
      assert.deepEqual @sentence.getWords(), [
        'I'
        'am'
        'bouzuya'
      ]
