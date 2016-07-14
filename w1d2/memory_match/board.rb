require_relative 'card.rb'

class Board
  attr_accessor :grid, :cards

  def initialize(cards, grid_size = 4)
    @cards = cards
    @grid = Array.new(grid_size) {Array.new(grid_size)}
    populate(grid_size)
  end

  def populate(grid_size)
    cards.shuffle!
    @grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        @grid[i][j] = @cards.pop
      end
    end
  end

  def render
    @grid.each_with_index do |row, i|
        print "\n"
      row.each_with_index do |square, j|
        print " #{@grid[i][j].display} "
      end
      print "\n"
    end
  end

  def won?
    @grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        return false unless grid[i][j].visible
      end
    end
    true
  end

  def reveal(guessed_pos)
    card = @grid[guessed_pos.first][guessed_pos.last]
    card.reveal unless card.visible
    card.face_value
  end



end
