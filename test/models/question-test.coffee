assert = require 'power-assert'
{Question} = require '../../src/models/question'
{Sentence} = require '../../src/models/sentence'

describe 'Question', ->
  describe '#answer', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @sentence = new Sentence(@text)
      @question = new Question(@sentence)

    it 'works', ->
      assert @question.answer @text
      assert not @question.answer @text + '!!!'

  describe '#getSentence', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @sentence = new Sentence(@text)
      @question = new Question(@sentence)

    it 'works', ->
      assert @question.getSentence() is @sentence

  describe '#getText', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @sentence = new Sentence(@text)
      @question = new Question(@sentence)

    it 'works', ->
      text = @question.getText()
      words = text.substring(0, text.length - 1).split(' ').sort()
      assert.deepEqual words, @sentence.getWords().sort()

  describe '#getWords', ->
    beforeEach ->
      @text = 'I am bouzuya.'
      @sentence = new Sentence(@text)
      @question = new Question(@sentence)

    it 'works', ->
      assert.deepEqual @question.getWords().sort(), @sentence.getWords().sort()
