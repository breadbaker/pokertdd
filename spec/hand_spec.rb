require 'rspec'
require 'card'
require 'deck'
require 'hand'

describe Hand do

  let(:cards) do
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit,value)
      end
    end

    cards
  end

  let(:hands) do
    {
      :flush => [0,1,2,4,5],
      :strait => [0,1,2,3,17],
      :three => [0,14,2,3,28],
      :two_pair => [0,14,2,16,1],
      :pair => [0,14,2,3,1]
    }
  end

  describe "#take_card" do
    let(:hand) do
      Hand.new
    end
    before(:all) do
      hand.take_card(cards[0])
    end
    it "card count changes" do
      hand.cards.length.should == 1
    end
    it "card has correct class" do
      expect(hand.cards[0].class).to eq(Card)
    end
    it "card has correct suit and value" do
      expect(hand.cards[0].value).to eq(:deuce)
      expect(hand.cards[0].suit).to eq(:spades)
    end
    it "should auto populate feed after user.add_friend" do
        FeedItem.should_receive(:populate_from_friend_to_user).with(@friend1, @user)
        @user.add_friend(@friend1)
      end
  end

  describe "#hand_type" do
    before(:all) do
      Hand.stub(:cards).and_return do
        cards
      end
    end
    it "returns best hand type for flush" do
      sel_cards = hands[:flush].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.hand_type).to eq(:flush)
    end
    it "returns best hand type for strait" do
      sel_cards = hands[:strait].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.hand_type).to eq(:strait)
    end
    it "returns best hand type for three of a kind" do
      sel_cards = hands[:three].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.hand_type).to eq(:three)
    end
    it "returns best hand type for two pair" do
      sel_cards = hands[:two_pair].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.hand_type).to eq(:two_pair)
    end
    it "returns best hand type for pair" do
      sel_cards = hands[:pair].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.hand_type).to eq(:pair)
    end
  end

  describe "#drop_cards" do
    before(:all) do
      cards = cards[0,4]
      Hand.stub(:cards).and_return do
        cards
      end
    end
    it "returns array of 5 card objects" do

      dropped = hand.drop_cards
      expect(dropped.length).to eq(5)
      expect(dropped[0].class).to eq(Card)
    end
    it "emptys cards in hand" do
      hand.drop_cards
      expect(hand.cards.empty?).to eq(true)
    end

  end

  describe "#high_card" do
    before(:all) do
      Hand.stub(:cards).and_return do
        cards
      end
    end
    it "flush" do
      Hand.stub(:hand_type).and_return {:flush}
      sel_cards = hands[:flush].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.high_card).to eq(5)
    end
    it "strait" do
      Hand.stub(:hand_type).and_return {:strait}
      sel_cards = hands[:strait].each do |i|
        cards[i]
      end
      cards = sel_cards

      expect(hand.high_card).to eq(4)
    end
  end
end

 #  describe "#hand" do
#     it "returns best hand type" do
#       cards = [
#         Card.new(:spades, :deuce),
#         Card.new(:spades, :three),
#         Card.new(:spades, :four),
#         Card.new(:spades, :five),
#         Card.new(:spades, :six)
#       ]
#   context "with two hands" do
#     let(:hand1) do
#       Hand.new([
#           Card.new(:spades, :ten),
#           Card.new(:spades, :four)
#         ])
#     end
#
#     let(:hand2) do
#       Hand.new([
#           Card.new(:spades, :ten),
#           Card.new(:spades, :jack)
#         ])
#     end
#
#     let(:busted_hand1) do
#       Hand.new([
#           Card.new(:spades, :ten),
#           Card.new(:spades, :jack),
#           Card.new(:spades, :queen)
#         ])
#     end
#
#     let(:busted_hand2) do
#       Hand.new([
#           Card.new(:spades, :ten),
#           Card.new(:spades, :jack),
#           Card.new(:spades, :four)
#         ])
#     end
#
#     describe "#beats?" do
#       it "awards win to higher hand" do
#         hand2.beats?(hand1).should be_true
#       end
#
#       it "can compare tied hands" do
#         hand1.beats?(hand1).should be_false
#       end
#
#       it "awards win if we didn't bust, but they did" do
#         hand1.beats?(busted_hand1).should be_true
#       end
#
#       it "never lets busted hand win" do
#         busted_hand1.beats?(busted_hand2).should be_false
#         busted_hand2.beats?(busted_hand1).should be_false
#       end
#     end
#   end
# end
