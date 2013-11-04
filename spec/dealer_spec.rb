require 'rspec'
require 'dealer'

describe Dealer do
  subject(:dealer) { Dealer.new }
  let(:cards) do
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit,value)
      end
    end

    cards
  end
  context "#deal" do
    let(:player1) do
      double("player1", :hand => Hand.new)
    end
    let(:player2) do
      double("player2", :hand => Hand.new)
    end
    let(:deck) do
      double("deck", :cards => cards)
    end
    before do
      deck = Deck.new(cards)
      players = [player1,player2]
    end
    it "call take card on each player 5 times" do
      Hand.stub(:draw).and_return(true)
      dealer.deal(players,deck)
      player1.hand.should_receive(:take_card).exactly(10).times
    end
    it "calls deck.draw 10 times" do
      deck.stub(:draw => true)
      dealer.deal(players,deck)
      deck.should_receive(:draw).exactly(10).times
    end
  end
  


  
 
end
