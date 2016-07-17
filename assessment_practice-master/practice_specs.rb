class Array
  def my_each(&prc)
  end

  def my_select(&prc)
  end

  def my_reject(&prc)
  end

  def my_any?(&prc)
  end

  def my_flatten
  end

  def my_zip(*other_arrays)
  end

  def my_rotate(shift = 1)
  end

  def my_join(delimeter = "")
  end

  def my_reverse
  end

  def bubble_sort(&prc)
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
