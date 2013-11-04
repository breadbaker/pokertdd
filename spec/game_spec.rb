require 'rspec'
require 'dealer'
require 'game'
require 'human_player'

describe Game do
  subject(:game) { Game.new(players, dealer, deck) }

  let(:players) { [player1, player2] }
  let(:player1) { HumanPlayer.new("player1", 100) }
  let(:player2) { HumanPlayer.new("player2", 200) }
  let(:deck) { Deck.new }
  let(:dealer) { Dealer.new }
  
  context "#pot" do
    it "init to zero" do
      expect(game.pot).to eq(0)
    end
  end

  context "#take_bet" do
    it "adds to pot" do
      game.take_bet(100)
      game

  describe "#request_bets" do
    it "queries each player for bets" do
      players.each { |p| p.should_receive(:request_bet).with(dealer) }

      game.request_bets
    end
  end

  describe "#play_hands" do
    it "has each player play in turn" do
      (players + [dealer])
        .each { |p| p.should_receive(:play_hand).with(deck) }

      game.play_hands
    end
  end

  describe "#resolve_bets" do
    it "has the dealer pay out" do
      dealer.should_receive(:pay_bets)

      game.resolve_bets
    end
  end

  describe "#return_cards" do
    it "has each player return their cards" do
      (players + [dealer])
        .each { |p| p.should_receive(:return_cards).with(deck) }

      game.return_cards
    end
  end

  describe "#play_round" do
    it "goes through the steps of a round" do
      [:deal_cards,
        :request_bets,
        :play_hands,
        :resolve_bets,
        :return_cards].each do |step|
        game.should_receive(step).ordered
      end

      game.play_round
    end
  end
end
