class LRUCache
  def initialize(size)
    @store = []
    @size = size
  end

  def count
    # returns number of elements currently in cache
    @store.length
  end

  def add(el)
    # adds element to cache according to LRU principle
    if @store.include?(el)
      @store.delete(el)
      @store << el
    elsif @store.length >= @size
      @store.shift
      @store << el
    else
      @store << el
    end
  end

  def show
    # shows the items in the cache, with the LRU item first
    print @store
  end

  private
  # helper methods go here!

end
