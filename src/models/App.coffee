# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', null

    @get('playerHand').on 'stand', =>
      console.log('playerStand');
      @get('dealerHand').dealerHit()

    @get('dealerHand').on 'stand', =>
      console.log('dealerStand')
      if @get('dealerHand').scores()[0] > @get('playerHand').scores()[0]
        @set 'winner', 'dealer wins'
      else
        @set 'winner', 'player wins'
      @trigger('gameOver',@)




    # @overMax()


    # @get('playerHand').on 'gameOver', -> 
    #   alert "You lose"

    # @get('dealerHand').on 'gameOver', =>
    #   dealerScore = @get('dealerHand').scores()[0]
    #   playerScore = @get('playerHand').scores()[0]
    #   final = Math.max(dealerScore,playerScore)

      
      

    
    # @get('dealerHand').on 'stand', =>
    #   dealerScore = @get('dealerHand').scores()[0]
    #   playerScore = @get('playerHand').scores()[0]
    #   if playerScore > dealerScore
    #     alert "You Won!"
    #   if dealerScore < playerScore
    #     alert "Dealer won you suck"
    #   else
    #     alert "meh"\
      


