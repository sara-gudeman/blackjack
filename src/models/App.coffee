# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on 'stand', ->
      dealerScore = @get 'dealerHand'.scores()[0]
      playerScore = @get 'playerHand'.scores()[0]
      console.log('in initialize')
      @endGame(playerScore, dealerScore)
    
  console.log(@get('dealerHand').scores())

  endGame: (playerScore, dealerScore) ->
    console.log('I made it')
    if playerScore > dealerScore
      alert "You Won!"
    if dealerScore < playerScore
      alert "Dealer won you suck"
    else
      alert "meh"



