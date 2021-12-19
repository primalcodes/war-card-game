# frozen_string_literal: true

require_relative 'card'
# ========================================================
# Deck of Cards
# ========================================================
class Deck
  SUITS = %w[clubs diamonds hearts spades].freeze  
  RANKS = (2..14).to_a # NOTE: No Jokers in WAR

  def initialize
    @cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(suit: suit, rank: rank)
      end
    end
  end

  def shuffle_cards
    @cards.shuffle
  end
end
