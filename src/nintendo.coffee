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

module.exports = (robot) ->
  robot.respond /search game (.*)/, (msg) ->
    query =
      qterm: msg.match[1]
      qhardware: "wii u",
      qdirection: "descend"
      qsortBy: "releaseDate"
      qcurrentreleased: 1

    msg.http("http://www.nintendo.com/json/content/get/game/filter")
      .header('Accept', 'application/json')
      .query(query)
      .get() (err, res, body) ->
        results = []
        response = JSON.parse(body)
        if response.total > 0
          gameNames = []
          response.game.forEach (gameCard)->
            gameNames.push "#{gameCard.title} (#{gameCard.id})"
          results = gameNames.join("\n")
        else
          results = "I didn't find any games for you"
        msg.reply results


