require 'pry'

SUITS = ['♦','♣','♠','♥']
VALUES =['2','3','4','5','6','7','8','9','10','J','Q','K','A']

class Card
# This class should contain the suit and the value and provide methods for determining what type of card it is (e.g. face card or ace).
  def initialize(value,suit)
    @value = value
    @suit = suit

  end

  def face_card?
    ['J','Q','K'].include?(@value)
  end

  def ace?
    @value == 'A'
  end

  def value
    if @value == 'A'
      @value = 11
    elsif @value == 'J' || @value == 'Q' || @value == 'K'
      @value = 10
    else
      @value.to_i
    end
  end


end



class Deck
# represent a collection of 52 cards. When dealing a hand this class can be used to supply the Card objects.
  def initialize
    @deck = []
    VALUES.each do |value|
      SUITS.each do |suit|
        @deck << Card.new(value, suit)
      end
    end

    @deck.shuffle!
  end

  def deal
    @deck.pop
  end
end




class Hand < Array
  def initialize
  @hand = []
  end

  def hand
    @hand
  end

  def calculate_score
    score = 0

    self.each do |card|
      score += card.value

    end
    score
  end

  def ace?
    result = false
    self.each do |card|
      if card.value == 11
         result = true
      else
        result = false
      end
    end
    @result = result
  end

  def hit

  end

end

deck = Deck.new

player_hand = Hand.new

2.times do
  player_hand << deck.deal
end


# puts player_hand.calculate_score

# puts player_hand.ace?

if player_hand.calculate_score > 21

#binding.pry


