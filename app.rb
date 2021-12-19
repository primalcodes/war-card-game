# frozen_string_literal: true

require 'byebug'
require_relative 'card'
require_relative 'deck'
require_relative 'player'

# ========================================================
# WAR
# ========================================================
# https://bicyclecards.com/how-to-play/war/
class War
  def initialize(player1:, player2: Player.new(player_number: 2, player_name: "\u{1f916}"))
    @player1 = player1
    @player2 = player2
    @deck = Deck.new.shuffle_cards
  end

  # --------------------------------------------------------
  # deal_cards:
  # The deck is divided evenly, with each player receiving 26 cards, 
  # dealt one at a time, face down. Anyone may deal first. Each 
  # player places their stack of cards face down, in front of them.
  # --------------------------------------------------------
  def deal_cards
    @deck.each_with_index do |card, i|
      @player1.receives_cards(cards: card) if i.even?
      @player2.receives_cards(cards: card) if i.odd?
    end
  end

  def play!
    deal_cards
    round = 0

    # The game ends when one player has won all the cards.
    until @player1.cards.empty? || @player2.cards.empty?
      round += 1

      p1_card = @player1.play_card
      p2_card = @player2.play_card

      puts "#{@player1.player_name}: #{p1_card.name} [vs] #{@player2.player_name}: #{p2_card.name}"

      winner = if p1_card.rank == p2_card.rank
                 war_time
               else
                 winner_of_round(p1_card: p1_card, p2_card: p2_card)
               end
      winner.receives_cards(cards: [p1_card, p2_card])

      puts "Score: #{@player1.score} to #{@player2.score}"
    end

    game_winner = [@player1, @player2].max_by(&:score)
    puts "\u{1f389} WINNER!!: #{game_winner.player_name} after #{round} hands played"
  end

  private

  def winner_of_round(p1_card:, p2_card:)
    if p1_card.rank > p2_card.rank
      @player1
    else
      @player2
    end
  end

  # --------------------------------------------------------
  # war_time:
  # If the cards are the same rank, it is War. Each player
  # turns up one card face down and one card face up. The player
  # with the higher cards takes both piles (six cards). If the
  # turned-up cards are again the same rank, each player places
  # another card face down and turns another card face up.
  # The player with the higher card takes all 10 cards, and so on.
  # --------------------------------------------------------
  def war_time
    puts
    puts "\n Cards of the same rank played - it's all-out war!"
    puts "\u{1F4A5} \u{1F4A3}" * 3
    winner = nil
    all_cards = []
    until winner
      # Place 2 cards down as war casualties
      all_cards += [@player1.play_card, @player2.play_card]

      # Draw two cards to battle it out
      p1_card = @player1.play_card
      p2_card = @player2.play_card

      if p1_card.nil? || p2_card.nil?
        puts 'Someone ran out of cards... to the victor go the spoils!'
        all_cards += [p1_card, p2_card]
        winner = p1_card.nil? ? @player2 : @player1
        winner.receives_cards(cards: all_cards.compact)
      end
      next if winner

      all_cards += [p1_card, p2_card]
      next if p1_card.rank == p2_card.rank

      winner = winner_of_round(p1_card: p1_card, p2_card: p2_card)
      winner.receives_cards(cards: all_cards.compact)
    end
    puts "#{winner.player_name} wins #{all_cards.length} cards"
    puts
    winner
  end
end

player1 = Player.new(player_name: "\u{1F9D1}")
game = War.new(player1: player1)
game.play!
