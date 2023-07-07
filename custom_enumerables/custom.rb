my_array = [2,3,4,5,6,7,2,2]
module Enumerable
  def my_each
    return enum_for unless block_given?
    array = is_a?(Range) ? to_a : self

    for item in array
      yield(item)
    end
    array
  end

  def my_each_with_index
    return enum_for unless block_given?
    array = is_a?(Range) ? to_a : self
    
    i = 0
    for item in array
      yield(item, i)
      i+=1
    end
    array
  end

  def my_select
    return enum_for unless block_given?
    selected = []

    my_each { |item| if yield(item) then selected << item end }
    return selected
  end

  def my_all?
    return enum_for unless block_given?

    value = true
    my_each { |item| unless yield(item) then value = false end }
    return value
  end

  def my_any?
    return enum_for unless block_given?

    value = false
    my_each { |item| if yield(item) then value = true end }
    return value
  end

  def my_none?
    return enum_for unless block_given?

    value = true
    my_each { |item| if yield(item) then value = false end }
    return value
  end

  def my_count(cond = nil)
    array = is_a?(Range) ? to_a : self
    return array.length unless block_given? || cond

    count = 0
    if cond
      my_each { |item| if item == cond then count += 1 end }
    else
      my_each { |item| if yield(item) then count += 1 end }
    end
    return count
  end

  def my_map
    mapped = []
    my_each { |item| mapped << yield(item) }
    return mapped
  end

  def my_inject
    acc = 0
  end
end



# my_array.my_each {|num| puts num }
# my_array.my_each_with_index {|num, index| puts "#{num}, index: #{index}"}
# puts my_array.my_select {|num| num.even?}
# puts my_array.my_all? {|item| item < 8}
# puts my_array.my_any? {|item| item < 2}
# puts my_array.my_none? {|item| item < 3}
# puts my_array.my_count()
puts my_array.my_map {|item| item*3}