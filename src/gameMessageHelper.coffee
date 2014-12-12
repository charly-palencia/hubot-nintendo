class GameMessageHelper
  constructor:  ->

  getGameRow: (game)->
    """
      #{game.title}
      id: #{game.id}
      link: http://www.nintendo.com/games/detail/#{game.id}
    """

  generateGameList: (games)->
    gameNames = []
    games.forEach (game) =>
      gameNames.push @getGameRow(game)
    gameNames.join("\n")

  generateGameDetail: (game)->
    """
      #{game.title}
      System: #{game.system}
      Release date: #{game.release_date}
      No of players: #{game.number_of_players}
      Category: #{game.genre}
      #{game.front_box_art.url}
    """
  generateGameNotFound: (query) ->
    "I didn't find any games with '#{query}'"

module.exports = GameMessageHelper

