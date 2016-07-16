class Stack
  def initialize
    @stack = []
  end

  def add(el)
    # adds an element to the stack
    @stack << el
  end

  def remove
    # removes one element from the stack
    @stack.pop
  end

  def show
    # return a copy of the stack
    @stack
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue
  end
end

class Map
  def initialize
    @map = []
  end

  def assign(key,value)
    if exists?(key)
      remove(key)
    end
    @map << [key, value]
  end

  def exists?(key)
    @map.each_with_index do |pair, i|
      if pair[0] == key
        return true
      end
    end
    false
  end

  def remove(key)
    @map.each_with_index do |pair, i|
      if pair[0] == key
        return @map.delete_at(i)
      end
    end
    nil
  end

  def show
    @map
  end
  
end
