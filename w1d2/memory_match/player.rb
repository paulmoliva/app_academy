require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'card.rb'

class HumanPlayer
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def make_guess(pos)
    card = process_position(pos)
    if @previous_guess
      @previous_guess.reveal
      card.reveal
      board.render
      unless @previous_guess == card
        @previous_guess.hide
        card.hide
      end
      @previous_guess = nil
    else
      @previous_guess = card
    end
  end

  def process_position(pos)
    board.grid[pos.first][pos.last]
  end

  def ask_for_guess
    answer = get_input
    until valid?(answer)
      puts "Invalid guess"
      answer = get_input
    end

    if @previous_guess
      card = board.grid[answer.first][answer.last]
      while duplicate_guess?(@previous_guess, card)
        puts "Duplicate guess"
        answer = get_input
        card = board.grid[answer.first][answer.last]
      end
    end
    answer
  end

  def get_input
    puts "Please enter a guess (x,y)"
    answer = gets.chomp
    answer.split(",").map(&:to_i)
  end

  def process_guess
    guess = ask_for_guess
    make_guess(guess)
  end

  def valid?(guess)
    within_board = guess.all? { |pos| pos < board.grid.length }
    return false unless within_board
    revealed = board.grid[guess.first][guess.last].visible
    hidden = true unless revealed
    hidden
  end

  def duplicate_guess?(guess1, guess2)
    guess1.object_id == guess2.object_id
  end

end
