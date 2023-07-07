# frozen_string_literal: true

puts 'Write whatever you want to be encrypted:'
input = gets
puts 'And now the shift value (default is 1):'
input_shift = gets.to_i

def encrypting(string, shift)
  shift.zero? ? shift = 1 : true
  to_numbers = string.bytes
  shifted = to_numbers.map do |number|
    if (number >= 65 && number < 90) || (number >= 97 && number <= 122) # letters?
      if number >= 65 && number < 90 # uppercase?
        if number + shift > 90 # out of range?
          number = number - 26 + shift
        else
          number += shift
        end
      elsif number >= 97 && number <= 122 # downcase?
        if number + shift > 122 # out of range?
          number = number - 26 + shift
        else
          number += shift
        end
      end
    else
      number = number
    end
  end
  back_char = shifted.map(&:chr)
  back_char.join
end

puts encrypting(input, input_shift)
