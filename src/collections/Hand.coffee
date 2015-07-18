class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    lastCard = @deck.pop()
    @add(lastCard)
    lastCard
    @overMax()
    # break

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
    @trigger('stand',@)
  
  dealerHit: -> 
    @.at(0).flip()
    if @hasAce == 1
      while @scores()[1] < 17
        @hit()
    else 
      while @scores()[0] < 17
        @hit()
    @stand()

  overMax: ->
    if @hasAce == 1
      if @scores()[0] > 21 and @scores()[1] > 21
        console.log('scores 0', @scores()[0])
        @trigger('gameOver', @)
    else
      console.log('minscore', @minScore())
      if @minScore() > 21
        @trigger('gameOver', @)
