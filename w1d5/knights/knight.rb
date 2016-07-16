require_relative 'node.rb'
require 'byebug'

class KnightPathFinder
  DELTAS = [ [2, -1], [2, 1], [1, 2], [-1, 2], [-1, -2], [-2, 1], [1, -2], [-1, -2] ]
  attr_reader :visited_positions

  def initialize(pos)
    @target = pos
    @visited_positions = [pos]
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.reject! {|el| visited_positions.include?(el) }
    moves.each { |el| visited_positions << el }
    moves
  end

  def self.valid_moves(pos)
    okay_moves = []
    DELTAS.each do |delta|
      row = delta.first + pos.first
      col = delta.last + pos.last
      move = [row, col]
      next unless move.all? { |el| el.between?(0, 7) }
      okay_moves << move
    end
    okay_moves
  end

  def build_move_tree(pos)
    root = Node.new(pos)
    queue = [root]
    until queue.empty?
      el = queue.shift
      moves = new_move_positions(el.value)
      moves.each  do |move|
        move_node = Node.new(move)
        move_node.parent = el
        queue << move_node
      end
    end
    #byebug
    root
  end

  def dfs_helper(root)
    return nil if root.nil?
    return root if root.value == @target

    root.children.each do |child|
      results = dfs_helper(child)
      return results unless results.nil?
    end
    nil
  end

  def bfs_helper(root)
    queue = [root]
    until queue.empty?
      el = queue.shift
      return el if el.value == @target
      el.children.each do |child|
        queue << child
      end
    end
    nil
  end

  def trace_back_path(destination_node)
    array_path = [destination_node.value]
    el = destination_node
    until el.value == @target
      el = el.parent
      array_path << el.value
    end
    array_path.reverse
  end

  def find_path(end_pos)
    root = build_move_tree(@target)
    destination_node = root.bfs(end_pos)
    trace_back_path(destination_node)
  end

end

knight = KnightPathFinder.new([0,0])
p knight.find_path([6,2])
