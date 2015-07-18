assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealer = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealer = deck.dealDealer()


  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47

  describe 'stand', ->
    it 'should flip over first card', -> 
      dealer.stand()
      assert.strictEqual dealer.at(0).get('revealed'), true
    it 'should add cards to dealer hand', ->
      dealer.stand()
      assert.strictEqual dealer.length, 2
    it 'should have dealer score >= 17', ->
      dealer.stand()
      assert.strictEqual dealer.scores()[0], 17
