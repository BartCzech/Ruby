# frozen_string_literal: true

words = %w[below Low down go going horn how howdy it i low own part partner
           sit]

def substrings(string, array)
  hash = {}
  array.each do |i|
    if string.include?(i.downcase)
      if hash.key?(i)
        hash[i.downcase.to_s] += 1
      else
        hash[i.downcase.to_s] = 1
      end
    end
  end
  pp hash
end

substrings('below', words)
