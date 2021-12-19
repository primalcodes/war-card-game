# frozen_string_literal: true

# ========================================================
# Card
# ========================================================
class Card
  attr_reader :suit, :rank

  def initialize(suit:, rank:)
    @suit = suit
    @rank = rank
  end

  def name
    "#{card_val} #{card_emoji}"
  end

  private

  def card_emoji
    {
      clubs: "\u{2663}",
      diamonds: "\u{2666}",
      hearts: "\u{2665}",
      spades: "\u{2660}"
    }[suit.to_sym]
  end

  def card_val
    case rank
    when 11
      'jack'
    when 12
      'queen'
    when 13
      'king'
    when 14
      'ace'
    else
      rank
    end
  end
end