class Array
  def my_each(&prc)
    idx = 0
    while idx < length
      prc.call(self[idx])
      idx += 1
    end
  end

  def my_select(&prc)
    result = []
    idx = 0
    while idx < length
      result << self[idx] if prc.call(self[idx])
      idx += 1
    end

    result
  end

  def my_reject(&prc)
    result = []
    idx = 0
    while idx < length
      result << self[idx] unless prc.call(self[idx])
      idx += 1
    end

    result
  end

  def my_any?(&prc)
    idx = 0
    while idx < length
      return true if prc.call(self[idx])
      idx += 1
    end

    false
  end

  def my_flatten
    return [] if empty?
  end

  def my_zip(*other_arrays)
    idx = 0
    result = []
    while idx < length
      result << [self[idx]]
      other_arrays.each do |array|
        result[-1] << array[idx]
      end
      idx += 1
    end

    result
  end

  def my_rotate(shift = 1)
    (shift % length).times { self.unshift(self.pop) }
    self
  end

  def my_join(delimeter = "")
    result = ""
    self.each_with_index do |el, idx|
      idx == self.length - 1 ? result << el : result << el + delimeter
    end

    result
  end

  def my_reverse
    result = []
    idx = 0
    while idx < length
      result.unshift(self[idx])
      idx += 1
    end

    result
  end

  def bubble_sort(&prc)
    prc ||= proc { |i, j| i < j }
    duped = dup
    sorted = false
    until sorted
      sorted = true
      idx = 0
      while idx < length - 1
        if prc.call(duped[idx + 1], duped[idx])
          duped[idx], duped[idx + 1] = duped[idx + 1], duped[idx]
          sorted = false
        end
        idx += 1
      end
    end

    duped
  end

end


p "#{[1, 2, [3, [4]]].my_flatten == [1, 2, 3, 4]}: my_flatten"
p "#{[1, 2, 3].my_zip([4, 5, 6], [7, 8, 9], [10, 11, 12]) == [[1, 4, 7, 10], [2, 5, 8, 11], [3, 6, 9, 12]]}: my_zip"
p "#{[1, 2, 3].my_rotate == [3, 1, 2]}: my_rotate"
p "#{[1, 2, 3, 4, 5].my_rotate(-2) == [3, 4, 5, 1, 2]}: my_rotate with negative argument"
p "#{%w[this is a test].my_join("&") == "this&is&a&test"}: my_join"
p "#{[1, 2, 3, 4, 5].my_reverse == [5, 4, 3, 2, 1]}: my_reverse"
p "#{[1, 6, 4, 1, 2, 7, 4].bubble_sort { |i, j| i < j } == [1, 1, 2, 4, 4, 6, 7]} bubble_sort with prc"

# a = [1, 2, 3]
# p a.my_any? { |el| el == 4 }

# a = []
# b = [1, 2, 3]
# b.my_each do |el|
#   a << el
# end
# p a

# a = [1, 2, 3]
# b = a.my_select { |el| el < 3 }
# p b



# a = [1, 2, 3]
# b = a.my_reject { |el| el < 2 }
# p b
