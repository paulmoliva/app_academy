require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'card.rb'
class ComputerPlayer
  attr_accessor :store, :board, :guess_store

  def initialize(board)
    @board = board
    @store = Array.new(@board.grid.length) {Array.new(@board.grid.length)}
    @guess_store = []
  end

  def duplicates_in_store?
    flat_store = @store.flatten
    (0...flat_store.length).each do |i|
      (i+1...flat_store.length).each do |j|
        if flat_store[i] == flat_store[j] && flat_store[i].is_a?(Fixnum)
          @guess_store = convert_matches([i,j])
          #byebug
          return true
        end
      end
    end
    false
  end

  def convert_matches(matches)
    result = []
    #byebug
    matches.each do |match|
      y = match % @board.grid.length
      x = match / @board.grid.length
      result << [x,y]
      @store[x][y] = "A"
    end
    result
  end

  def store_random_guesses
    @guess_store = [[rand(@board.grid.length), rand(@board.grid.length)], [rand(@board.grid.length), rand(@board.grid.length)]]
    until @guess_store.all? {|el| valid?(el)}
      @guess_store = [[rand(@board.grid.length), rand(@board.grid.length)], [rand(@board.grid.length), rand(@board.grid.length)]]
    end
  end

  def update_store
    @guess_store.each do |i|
      store[i.first][i.last] = board.grid[i.first][i.last].face_value
    end
  end

  def valid?(guess)
    within_board = guess.all? { |pos| pos < @board.grid.length }
    return false unless within_board
    revealed = @board.grid[guess.first][guess.last].visible
    hidden = true unless revealed
    hidden
  end

  def process_guesses
    2.times{make_guess(@guess_store.pop)}
  end

  def process_position(pos)
    p pos
    p @store
    @board.grid[pos.first][pos.last]
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

  def duplicate_guess?(guess1, guess2)
    guess1.object_id == guess2.object_id
  end

  def play_guesses
    if duplicates_in_store?
      process_guesses

    else
      store_random_guesses
      update_store
      process_guesses
    end
  end

end
