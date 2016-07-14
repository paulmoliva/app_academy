def sum_to(n)
  return 1 if n == 1
  n + sum_to(n-1)
end

def add_numbers(num_array)
  return num_array.first if num_array.length <= 1
  num_array.first + add_numbers(num_array[1..-1])
end

def gamma(n)
  return nil if n == 0
  return 1 if n == 1
  (n-1) * gamma(n-1)
end
