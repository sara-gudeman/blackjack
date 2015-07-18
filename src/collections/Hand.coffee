class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    lastCard = @deck.pop()
    @add(lastCard)
    lastCard

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: -> 
    #player can't hit anymore, disable both buttons
    #dealer's first card is revealed
    @.at(0).flip()

    while @scores()[1] < 17 and @scores()[0] < 17
      @add(@deck.pop())
    

    @trigger('stand',@)
      
    # if @
    # while @scores() < 17 
    #   @add(@deck.pop())


# var minScore = function(score, card) {
#   reduce(score, card)
# }

# while score < 17
#   flip card
#   minScore(score, flippedCard)

#   keeping track two scores
#   take the smaller score
#   when that score is greater than 17

    
# if scores of 1 = 17 or greater on flip, then compare scores and end game
# else, scores of 0 keep flipping until 17