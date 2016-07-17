require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    if game.board.rows.all? {|row| row.all? {|cell| cell.nil?}}
      return [1,1]
    end
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    #raise error if children.reject!{|el| el.losing_node?(mark)}.nil?
    children.reject{|el| el.losing_node?(mark)}.sample.prev_move_pos
  end
end
if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = SuperComputerPlayer.new
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
