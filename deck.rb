# frozen_string_literal: true

require_relative 'card'
# ========================================================
# Deck of Cards
# ========================================================
class Deck
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(suit: suit, rank: rank)
      end
    end
  end

  def shuffle_cards
    @cards.shuffle
  end
end
