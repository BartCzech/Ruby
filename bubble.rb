# frozen_string_literal: true

require 'pry-byebug'
numbers = [90, 23, 56, 43, 75, 1, 7]

(0..(numbers.length - 2)).each do |i|
  (0..(numbers.length - 2)).each do |j|
    next unless numbers[j] > numbers[j + 1]

    binding.pry

    temporary = numbers[j]
    numbers[j] = numbers[j + 1]
    numbers[j + 1] = temporary
  end
end
puts numbers
