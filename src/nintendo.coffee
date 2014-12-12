# Description:
#   Search nintendo games
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot search game [query] - Hubot search nintendo games
#
# Author:
#   chalien
RequestHelper = require("./requestHelper")
GameMessageHelper = require("./gameMessageHelper")

module.exports = (robot) ->
  messageHelper = new GameMessageHelper()

  robot.respond /nintendo search (.*)/, (msg) ->
    query =
      qterm: msg.match[1]
      qdirection: "descend"
      qsortBy: "releaseDate"
      qcurrentreleased: 1
    url =  "http://www.nintendo.com/json/content/get/game/filter"

    nintendoClient = new RequestHelper(msg)
    nintendoClient.get(query, url,
      failure: ->
        msg.reply messageHelper.generateGameNotFound(msg.match[1])

      success: (results) ->
        msg.reply messageHelper.generateGameList(results)
    )

  robot.respond /nintendo show (.*)/, (msg) ->
    query =
      qid: msg.match[1]
      qdirection: "descend"
      qsortBy: "releaseDate"
      qcurrentreleased: 1

    url = "http://www.nintendo.com/json/content/get/game/list/filter/subset"

    nintendoClient = new RequestHelper(msg)
    nintendoClient.get(query, url,
      failure: ->
        msg.reply messageHelper.generateGameNotFound(msg.match[1])

      success: (results) ->
        msg.reply messageHelper.generateGameDetail(results[0])
    )


