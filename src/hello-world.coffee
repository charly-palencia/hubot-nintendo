# Description:
#   Say Hi to Hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   nana search game
#
# Author:
#   tombell

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
          response.game.forEach (gameCard)->
            results.push gameCard.title
        else
          results = "I didn't find any games for you"

        msg.reply results

