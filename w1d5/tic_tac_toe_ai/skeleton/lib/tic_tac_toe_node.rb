require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      winner = board.winner
      return false if winner == evaluator || winner.nil?
      return true
    else
      if next_mover_mark == evaluator
        return true if children.all?{|el| el.losing_node?(evaluator)}
      else
        return true if children.any?{|el| el.losing_node?(evaluator)}
      end
    end
    false
  end

  def winning_node?(evaluator)
    if board.over?
      winner = board.winner
      return true if winner == evaluator
      return false
    else
      if next_mover_mark == evaluator
        return true if children.any?{|el| el.winning_node?(evaluator)}
      else
        return true if children.all?{|el| el.winning_node?(evaluator)}
      end
    end
    false
  end

  def mark_switcher(mark)
    mark == :x ? :o : :x
  end
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    positions = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if square.nil?
          dup = board.rows.deep_dup
          dup[i][j] = @next_mover_mark
          result << dup
          positions << [i, j]
        end
      end
    end
    result.map.with_index {|el, i| TicTacToeNode.new(Board.new(el), mark_switcher(@next_mover_mark), positions[i])}
  end
end

class Array
  def deep_dup
    return self.dup if self.none?.is_a?(Array)
    result = []
    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result << el
      end
    end
    result
  end

end
