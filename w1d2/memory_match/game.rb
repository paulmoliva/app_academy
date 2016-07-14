require_relative 'card.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'computer_player.rb'

require 'byebug'
class Game
  attr_accessor :board, :previous_guess, :player

  def initialize(board, player)
    @board = board
    @previous_guess = nil
    @player = player
  end

  def play
    until board.won?
      board.render
      #byebug
      if player.is_a?(HumanPlayer)
        2.times { @player.process_guess }
      else
        #byebug
        @player.play_guesses
      end
        sleep(1)
        system("clear")


    end
    puts "you win!"

  end


end

  if __FILE__ == $PROGRAM_NAME
    n = (1..8).to_a
    n += n
    cards = []
    n.each {|l| cards << Card.new(l)}
    board = Board.new(cards, 4)
    player = ComputerPlayer.new(board)
    game = Game.new(board, player)
    game.play
  end
