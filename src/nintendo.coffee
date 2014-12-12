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
            gameNames.push """

            #{gameCard.title}
            id: #{gameCard.id}
            link: http://www.nintendo.com/games/detail/#{gameCard.id}
            """
          results = gameNames.join("\n")
        else
          results = "I didn't find any games with '#{msg.match[1]}'"
        msg.reply results

  robot.respond /show game (.*)/, (msg) ->
    query =
      qid: msg.match[1]
      qhardware: "wii u",
      qdirection: "descend"
      qsortBy: "releaseDate"
      qcurrentreleased: 1

    msg.http("http://www.nintendo.com/json/content/get/game/list/filter/subset")
      .header('Accept', 'application/json')
      .query(query)
      .get() (err, res, body) ->
        results = []
        response = JSON.parse(body)
        if response.total > 0
          gameCard = response.game
          results =  """

          #{gameCard.title}
          System: #{gameCard.system}
          Release date: #{gameCard.release_date}
          No of players: #{gameCard.number_of_players}
          Category: #{gameCard.genre}
          #{gameCard.front_box_art.url}
          """
        else
          results = "I didn't find any games with '#{msg.match[1]}'"
        msg.reply results


