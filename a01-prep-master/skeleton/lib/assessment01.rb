require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    accumulator.nil? ? i = 1 : i = 0
    accumulator ||= self[0]
    self[i..-1].each{|el| accumulator = prc.call(accumulator, el)  }
    accumulator
  end

end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2..num/2).none?{|el| num%el == 0}
end

def primes(num)
  result = []
  i = 2
  until result.length == num
    result << i if is_prime?(i)
    i += 1
  end
  result
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.



def factorials_rec(num)
  if num == 1
    [1]
  else
    facs = factorials_rec(num - 1)
    facs << (num - 1) * facs.last
  end
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    counts = Hash.new { |hash, key| hash[key] = [] }
    self.each_with_index { |e, i| counts[e] << i if count(e) > 1}
    counts
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    result = []
    (0...self.length).each do |i|
      (i+1...self.length).each do |j|
        result << self[i..j]
      end
    end
    result.select{|el| el == el.reverse}
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new {|e, f| e <=> f}
    return self if length <= 1
    mid = length / 2
    left = self.take(mid)
    right = self.drop(mid)
    Array.merge(left.merge_sort(&prc), right.merge_sort(&prc), &prc)
  end

  private
  def self.merge(left, right, &prc)
    result = []
    until left.empty? || right.empty?
      if prc.call(left.first, right.first) < 1
        result << left.shift
      else
        result << right.shift
      end
    end
      result.concat(left).concat(right)
  end
end

class Array
  def b_search(target)
    mid = length/2
    return mid if self[mid] == target
    if self[mid] > target
      return self[0...mid].b_search(target)
    else
      return mid + 1 + self[mid+1..-1].b_search(target)
    end
  end
end

p [1,2,3,4,5].b_search(3) == 2
p [1,2,3,4,5].b_search(5) == 4
p [1,2,3,4,5].b_search(1) == 0
