class ResultFormatter
  constructor: (@result) ->

  parsedResult: ->
    return [@result.game] if @result.total == 1
    @result.game

module.exports = ResultFormatter

