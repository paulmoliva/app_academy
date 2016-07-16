

class Node

  attr_reader :value

  def initialize(val)
    @value = val
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def parent=(node)
    parent.children.delete(self) unless parent.nil?
    @parent = node
    # it was trying to .children on nil, so we added node.nil? to avoid
    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self unless self.children.include?(child_node)
  end

  def remove_child(child)
    raise 'not a child' unless self.children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      results = child.dfs(target_value)
      return results unless results.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      el = queue.shift
      return el if el.value == target_value
      el.children.each{|child| queue << child}
    end
    nil
  end


end
