require_relative 'player.rb'

class Game
  attr_accessor :fragment, :player1, :player2, :dictionary, :current_player, :previous_player, :losses

  def read_dictionary(filename)
    dict = []
    File.open(filename).each do |line|
      dict << line.chomp
    end
    dict
  end

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @dictionary = read_dictionary('dictionary.txt')
    @fragment = ''
    @current_player = player1
    @previous_player = player2
    @losses = {player1 => 0, player2 => 0}
  end

  def record(player)
    puts "#{player.name}'s record: "
    ghost = 'GHOST'
    if losses[player] > 0
      puts ghost[0..losses[player]-1]
    else
      puts 'clean record!!'
    end
  end

  def run
    until losses.values.any?{|el| el == 5}
      play_round
    end
  end

  def play_round
    [@player1, @player2].each {|el| record(el)}
    until win?
      take_turn(current_player)
    end
    puts "#{current_player.name} wins!! :)"
    @losses[previous_player] += 1
    @fragment = ''
  end

  def win?
    dictionary.include?(fragment)
  end
'''
  def current_player
    player1
  end

  def previous_player
    player2
  end
  '''

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn(player)
    new_word = 'zzzz'
    until valid_play?(new_word)
      puts "The current fragment is #{@fragment}"
      puts "enter a letter, #{player.name}: "
      letter = gets.chomp
      if letter.length > 1
        puts "one letter please!"
        letter = "zzzzzzzzzzz"
      end
      new_word = fragment + letter
      puts "not a valid play." unless valid_play?(new_word)
    end
    @fragment = new_word
    next_player!
  end

  def valid_play?(string)
    dictionary.each do |word|
      if substrings(word).include?(string)
        return true
      end
    end
    return false
  end

  def substrings(string)
    result = []
    (0...string.length).each do |i|
      result << string[0..i]
    end
    result.uniq
  end

end
