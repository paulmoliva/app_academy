require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    if accumulator.nil?
      i = 1
      accumulator = self[0]
    else
      i = 0
    end
    self[i..-1].each do |el|
      accumulator = prc.call(accumulator, el)
    end
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

def fact(n)
  (1..n).reduce(:*)
end

def factorials_rec(num)
  if num == 1
    [1]
  else
    facs = factorials_rec(num - 1)
    facs << facs.last * (num - 1)
    facs
  end
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    result = Hash.new{|h, k| h[k] = []}
    counts = Hash.new(0)
    self.each do |el|
      counts[el] += 1
    end
    self.each_with_index do |el, i|
      result[el] << i if counts[el] > 1
    end
    result
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
    result.select{|el| el == el.reverse && el.length > 1}
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new {|x,y| x <=> y}
    return self if self.length <= 1
    split = length/2
    left = self[0...split]
    right = self[split..-1]
    Array.merge(left.merge_sort(&prc), right.merge_sort(&prc), &prc)
  end

  private
  def self.merge(left, right, &prc)
    return left if right.empty?
    return right if left.empty?
    merged = []
    until left.empty? || right.empty?
      prc.call(left.first, right.first) < 1 ? merged << left.shift : merged << right.shift
    end

      merged += left
      merged += right

      merged
  end
end
