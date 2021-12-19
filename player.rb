# frozen_string_literal: true

# ========================================================
# Player
# ========================================================
class Player
  attr_reader :cards, :player_name

  def initialize(player_name:, player_number: 1)
    @player_name = player_name
    @player_number = player_number
    @cards = []
  end

  def receives_cards(cards:)
    @cards = (@cards << cards).flatten.shuffle
  end

  def play_card
    @cards.shift
  end

  def score
    @cards.length
  end
end