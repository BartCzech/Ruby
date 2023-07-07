# This program contains classes which can create a special kind of a graph, known 
# as a 'path', which is wider known among programmers as a 'linked list'.

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize()
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value) #add to the end of the list
    @tail = Node.new(value, nil)
    if @head.nil?
      @head = Node.new(value, nil)
    else
      last_node = @head
      while(!last_node.next_node.nil?) #unless we are at the end of the list
        last_node = last_node.next_node 
      end
      last_node.set_next_node(Node.new(value, nil))
    end
    @size += 1
  end

  def insert_at(index, value)
    if index > @size
      puts 'Given index exceeds the size of the list.'
      return nil
    end

    if index == 0
      append(value)
    elsif index == @size
      prepemd(value)
    else
      count = 1
      last_node = @head
      while(index > count)
        last_node = last_node.next_node
        count += 1
      end
      last_node.next_node = Node.new(value, last_node.next_node)
    end
  end

  def prepemd(value) #add to the beginning of the list
    if @head.nil?
      @head = Node.new(value, nil)
      @tail = Node.new(value, nil)
    else
      last = @head
      @head = Node.new(value, last)
      future = nil
      while(!last.next_node.nil?)
         future = last.next_node
         last = future
      end
    end
    @size += 1
  end

  def get_size()
    return @size
  end

  def get_tail
    return @tail
  end

  def at(index)
    node = @head
    while(index > 0)
      node = node.next_node
      index -= 1
    end
    return node
  end

  def pop()
    if @head.nil?
      puts 'No elements in the linked list'
      return nil
    else
      last_node = @head
      while(!last_node.next_node.next_node.nil?) 
        last_node = last_node.next_node 
      end
        last_node.set_next_node(nil)
        @tail = last_node
    end
    @size -= 1
  end

  def remove_at(index)
    if index >= @size
      puts 'The item of such index doesn\'t exist in the linked list.'
      return nil
    end
    count = 0
    last_node = @head
    previous_node = @head
    
    while(index > count)
        previous_node = last_node
        last_node = last_node.next_node
        count += 1
    end
    if index == 0
      @head = last_node.next_node
    else
      previous_node.next_node = previous_node.next_node.next_node
    end 
  end

  def contains?(value)
    checked_node = @head
    while(checked_node.value != nil)
      if checked_node.value == value
        return true
      elsif checked_node.next_node == nil
        return false
      end
      checked_node = checked_node.next_node
    end    
  end

  def find(value)
    checked_node = @head
    index = 0
    while(checked_node.value != nil)
      if checked_node.value == value
        return index
      elsif checked_node.next_node == nil
        return nil
      end
      checked_node = checked_node.next_node
      index += 1
    end
  end

  def print_path()
    current_node = @head
    while(current_node != nil)
      print '( ' + current_node.value.to_s + ' ) -> '
      current_node = current_node.next_node
    end
    print "nil\n"
  end
end

class Node 
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def set_value(num)
    @value = num
  end

  def set_next_node(num)
    @next_node = num
  end
end

ll = LinkedList.new()
ll.append(10)
ll.append(20)
ll.append(30)
ll.append(40)
ll.insert_at(1, 15)
ll.pop()
ll.print_path