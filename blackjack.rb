require 'pry'

SUITS = ['♦','♣','♠','♥']
VALUES =['2','3','4','5','6','7','8','9','10','J','Q','K','A']

class Card
  attr_reader :suit, :value

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

  def points
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
      score += card.points
    end
    score
  end

  def ace?
    result = false
    self.each do |card|
      if card.points == 11
         result = true
      else
        result = false
      end
    end
    @result = result
  end

  def ace_count
    @ace_count = 0
    self.each do |card|
      if card.points == 11
        @ace_count += 1
      end
    end
    @ace_count
  end
end

def bust_check(score)
  score > 21
end

deck = Deck.new
player_hand = Hand.new


puts "Welcome to Blackjack!"
puts
2.times do
  player_hand << deck.deal
end

player_hand.each do |card|
  puts "Player was dealt #{card.value}#{card.suit}"
end

puts "Player score: #{player_hand.calculate_score}"

while true
  print "Hit or Stand (H/S): "
  choice = gets.chomp.downcase

  if choice == 'h'
    player_hand << deck.deal

    last_deal = player_hand.last
    puts "Player was dealt #{last_deal.value}#{last_deal.suit}"
    puts

    p_score = player_hand.calculate_score
    if player_hand.ace_count > 0
      count = player_hand.ace_count
      while p_score > 21 && count > 0
        p_score -= 10
        count -= 1
      end
      puts "Player score is #{p_score}"
    else
      puts "Player score is #{p_score}"
    end
    if bust_check(p_score)
      puts "Bust! You lose."
      break
    end
  elsif choice == 's'
    break
  else
    puts "Please enter a valid input."
  end
end

puts
puts
puts

if !bust_check(player_hand.calculate_score)

  dealer_hand = Hand.new

  2.times do
    dealer_hand << deck.deal
  end
  dealer_hand.each do |card|
    puts "Dealer was dealt #{card.value}#{card.suit}"
  end

   d_score = dealer_hand.calculate_score

  while d_score < 17
    dealer_hand << deck.deal
    last_deal = dealer_hand.last
    puts "Dealer was dealt #{last_deal.value}#{last_deal.suit}"
    d_score += dealer_hand.calculate_score

  end

  puts "Dealer score: #{d_score}"
  puts

   if d_score > 21
      puts "Dealer bust! You win!"
    elsif d_score > player_hand.calculate_score
      puts "Dealer wins!"
    else
      "You win!"
    end
else
  puts "Game over."
end

