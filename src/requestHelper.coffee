ResultFormatter = require("./resultFormatter")

class RequestHelper
  constructor: (@msg) ->

  resultFormatter: ->
    @_resultFormatter ||= new ResultFormatter(@result)

  get: (query, url, callback)->
    @msg.http(url)
      .header('Accept', 'application/json')
      .query(query)
      .get() (err, res, body) =>
        @result = JSON.parse(body)
        return callback.failure() if @result.total == 0
        callback.success(@resultFormatter().parsedResult())

module.exports = RequestHelper
