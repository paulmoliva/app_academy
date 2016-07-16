

class PolyTreeNode

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
    @parent = node
    node.children << self
  end

end
