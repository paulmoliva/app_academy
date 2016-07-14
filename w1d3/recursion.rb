def range(start, finish)
  return [] if start >= finish - 1
  initial = [start + 1]
  initial += range(start + 1, finish)
end

def iterative_range(start, finish)
  (start + 1...finish).to_a
end

def exp1(b, n)
  return 1 if n == 0
  b * exp1(b, n-1)
end

def exp2(b,n)
  return 1 if n == 0
  exp2(b, n / 2) * exp2(b, n/2) if n.even?
  b * (exp2(b, (n-1)/2) * exp2(b, (n-1)/2)) if n.odd?
end

class Array
  def deep_dup
    return self.dup if self.none?.is_a?(Array)
    result = []
    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result << el
      end
    end
    result
  end

end

# arr = [1, [2], 3, [4]]
# arr2 = arr.deep_dup
# p arr2
# arr2.last << 5
# p arr2
# p arr

def fibonacci(n)
  return [1] if n == 1
  return [1,1] if n == 2
  result = fibonacci(n - 1)
  result << (result[-1] + result[-2])
  result
end


# p fibonacci(1)
# p fibonacci(10)


def bsearch (arr, target)
  pivot = arr.length/2
  return pivot if arr[pivot] == target
  return nil if arr.empty?
  if arr[pivot] < target
    search_result = bsearch(arr[pivot + 1..-1], target)
    return pivot + 1 + search_result unless search_result.nil?
  else
    bsearch(arr[0...pivot], target)
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
require 'byebug'
def merge_sort(arr)
  len = arr.length
  return arr if len <= 1

  left = arr[0...len/2]
  right = arr[len/2..-1]

  left = merge_sort(left)
  right = merge_sort(right)

  merge(left, right)
end

def merge(left, right)

  first_left = left.first
  first_right = right.first
  if first_left < first_right
    [first_left] + merge_sort(left[1..-1] + right)
  else
    [first_right] + merge_sort(right[1..-1] + left)
  end
end
# p merge_sort([10,3,2,4,5,9,11,8,6].shuffle)



def subsets(arr)
  return arr << [] if arr.length <= 0

  result = []

  (1..arr.length).each do |el|
    combos = arr.combination(el).to_a
    combos.select! { |com| com[0] = arr[0] }
    result += combos
  end
  result.uniq!
  (result + subsets(arr[1..-1])).sort_by{|el| el.length}
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def greedy_make_change(amount, coins)
  #byebug
  return [] if coins.empty?
  return greedy_make_change(amount, coins[1..-1]) if (amount < coins.max)
  result = [0]
  until (result.reduce(:+) + coins.max) > (amount)
    result << coins.max
  end
  total = result.flatten.reduce(:+)
  result.reject! { |el| el.zero? }
  (result << greedy_make_change(amount - total, coins[1..-1])).flatten
end

#p greedy_make_change(29, [10,7,1])

# def make_better_change(amount, coins)
#   return [coins.max] if coins.max == amount
#   result = [0]
#   if result.reduce(:+) + coins.max > amount
#     result.shift
#     result << make_better_change(amount, coins[1..-1])
#   else
#     result << [coins.max] + make_better_change(amount-coins.max, coins)
#   end
#   result.flatten.reject { |el| el == 0}
# end

def make_better_change(amount, coins)
return [] if amount <= 0
bucket = []
coins.each do |coin|
  result = []
  result << coin
  change = make_better_change(amount - coin, coins)
  result << change
  bucket << result
end
bucket.map!(&:flatten)
bucket.select{|el| el.reduce(:+) == amount}.sort_by{|el| el.length}[0]

end
p make_better_change(24, [10,7,1])
