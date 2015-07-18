assert = chai.assert
expect = chai.expect

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

  describe 'Dealer Hit', ->
    it 'should flip over first card', -> 
      dealer.dealerHit()
      assert.strictEqual dealer.at(0).get('revealed'), true
    it 'should add cards to dealer hand', ->
      dealer.dealerHit()
      expect(dealer.length).to.be.at.least(2)
    it 'should have dealer score >= 17', ->
      dealer.dealerHit()
      expect(dealer.scores()[0]).to.be.at.least(17) or expect(dealer.scores()[1]).to.be.at.least(17)

  describe 'Over Max', ->
    it 'should end the game if the player goes over 21', ->

      # expect(maxSpy).to.be.a.spy
      hand.hit()
      hand.hit()
      hand.hit()
      # expect(maxSpy).to.have.been.called()
      expect(hand.overMax).to.have.been.called()
