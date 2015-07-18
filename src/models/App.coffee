# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', null

    @get('playerHand').on 'stand', =>
      
      @get('dealerHand').dealerHit()

    @get('dealerHand').on 'stand', =>
      dealerScore = if @get('dealerHand').scores()[1] > 21 then @get('dealerHand').scores()[0] else @get('dealerHand').scores()[1]
      playerScore = if @get('playerHand').scores()[1] > 21 then @get('playerHand').scores()[0] else @get('playerHand').scores()[1]
      if dealerScore > playerScore
        @set 'winner', 'You Lose!'
      else if playerScore > dealerScore
        @set 'winner', 'You Win!'
      else
        @set 'winner', 'Tie!'
      @trigger('ended',@)

    @get('playerHand').on 'gameOver', =>
      @set 'winner', 'You Lose!'
      @trigger('ended',@)

    @get('dealerHand').on 'gameOver', =>
      @set 'winner', 'You Win!'
      @trigger('ended',@)