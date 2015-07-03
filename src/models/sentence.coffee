class Sentence
  constructor: (@text, @translated) ->

  getText: ->
    @text

  getTranslatedText: ->
    @translated

  getWords: ->
    s = @text
    s = s.substring(0, s.length - 1) if s[s.length - 1] is '.'
    s.split /\s+/

module.exports.Sentence = Sentence
