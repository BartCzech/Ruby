def fibs(index)
  numbers = Array.new(index)
  numbers[0] = 0
  numbers[1] = 1
  for i in (2..index - 1)
    numbers[i] = numbers[i - 1] + numbers[i - 2]
  end
  pp numbers
end

def fibs_rec(n)
  n < 2 ? n : fibs_rec(n - 1) + fibs_rec(n - 2)
end

#fibs(8)
for i in (0..8)
  pp fibs_rec(i)
end