# frozen_string_literal: true

# prices = [17,3,6,9,15,8,6,1,10]

# def stock_picker(array)
#   max = 0
#   days = []
#   for i in array
#     for j in array
#       if (i - j > max)
#         max = array[i] - array[j + i]
#         days[0] = array.index(i)
#         days[1] = array.index(j + i)
#       end
#     end
#   end
#   pp max
# end

# stock_picker(prices)

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]

def stock_picker(array)
  max = 0
  days = []
  array.each do |element_1|
    array.each do |element_2|
      next unless element_2 - element_1 > max && (array.index(element_1) < array.index(element_2))

      max = element_2 - element_1
      days[0] = array.index(element_1)
      days[1] = array.index(element_2)
    end
    # array.delete_at(0)
  end
  puts("Day of buying: #{days[0]}, Day of selling: #{days[1]}")
  puts("Profit: #{max}$")
end

stock_picker(prices)
