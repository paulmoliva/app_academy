require 'byebug'

class Array
  def my_each(&proc)
    i = 0
    until i == self.length do
      proc.call(self[i])
      i+=1
    end
    return self
  end

  def my_select(&proc)
    results = []
    self.my_each do |el|
      results << el if proc.call(el)
    end
    results
  end

  def my_reject(&proc)
    results = []
    self.my_each do |el|
      results << el unless proc.call(el)
    end
    results
  end

  def my_any?(&proc)
    self.my_each do |el|
      return true if proc.call(el)
    end
    return false
  end

  def my_all?(&proc)
    self.my_each do |el|
      return false if !proc.call(el)
    end
    return true
  end

  def my_flatten
    i =0
    results = []
    until i == self.length
      unless self[i].is_a?(Array)
        results << self[i]
      else
        results += self[i].my_flatten
      end
      i+=1
    end
    return results
  end

  def my_zip(*args)
    arr = []
    self.each_with_index do |el, i|
      arr[i] = [el]
      args.each {|arg| arr[i] << arg[i]}
    end
    arr
  end

  def my_rotate(shift=1)
    if shift < 0
      shift.abs.times do
        self.unshift(self.pop)
      end
    else
      shift.times do
        self << self.shift
      end
    end
    self
  end

  def my_join(separator="")
    self.map {|letter| letter + separator}.reduce(:+)[0..self.length+(self.length-1)*separator.length-1]
  end

  def my_reverse
    i = self.length - 1
    arr = []
    until i < 0
      arr << self[i]
      i -= 1
    end
    arr
  end
end
