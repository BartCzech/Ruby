class Node 
  attr_accessor :data, :left, :right
  
  def initialize(data, left = nil, right = nil) # left, right)
    @data = data
    @left = left
    @right = right
  end

  def set_left(left_node)
    @left = left_node
  end 

  def set_right(right_node)
    @right = right_node
  end

  def add_child(data)
    if data == @data
      return
    end

    if data < @data
      if @left
        @left.add_child(data)
      else
        @left = Node.new(data)
      end
    else
      if @right
        @right.add_child(data)
      else
        @right = Node.new(data)
      end
    end
  end
  
  def minimum()
    if @left == nil 
      new_node = Node.new(@data) #flawed, update: fixed! :)
      new_node.set_right(@right)
      return new_node
    else
      @left.minimum()
    end
  end

  def next_biggest(data)

  end

  def delete(data)  
    # I know. It is ugly as fuck! And you will never fully understand it. Neither will I ever again. 
    # But it is absolutely perfect and covers all possible cases. (Or rather I accept to believe this to be true...)
    # And even though it is uglier than you could have imagined... I am quite proud of what I have created. ;)
    if data < @data 
      if @left != nil
        if @left.data == data 
          if @left.left == nil && @left.right == nil #leaf
            @left = nil
          elsif @left.left != nil && @left.right == nil #1 child
            @left = left.left
          elsif @left.right != nil && @left.left == nil #1 child
            @left = left.right
          elsif @left.right != nil && @left.left != nil #2 children. 
            # There will be 2 cases.      
            temp = @left.right.minimum #14
            # 1 - our minimum is a leaf
            if temp.left == nil && temp.right == nil
              if temp.data != @right.right.data
                temp.right = @left.right #75 -> 80
              end
              temp.left = @left.left #60 <- 75 -> 80
              delete(temp.data)
              @left = temp
            elsif temp.right != nil
            # 2 - our minimum has right subtree.
              temp.left = @left.left #12 <- 14 
              right_node = @left.right #14
              if right_node.data == temp.data
                pp temp.right.data
                right_node = temp.right #15
              else
                right_node.left = temp.right # 34 <- 40
              end
              temp.right = right_node #20 <- 32 -> 40
              @left = temp
            end
          end 
        else
          @left.delete(data)
        end
      end
    else
      if @right != nil
        if @right.data == data #leaf
          if @right.left == nil && @right.right == nil #leaf
            @right = nil
          elsif @right.left != nil && @right.right == nil #1 child
            @right = right.left
          elsif @right.right != nil && @right.left == nil #1 child
            @right = right.right
          elsif @right.right != nil && @right.left != nil #2 children
            # There will be 2 cases.      
            temp = @right.right.minimum #20
            if temp.left == nil && temp.right == nil # 1 - our minimum is a leaf
              if temp.data != @right.right.data
                temp.right = @right.right #75 -> 80
              end
              temp.left = @right.left #60 <- 75 -> 80
              delete(temp.data)
              @right = temp
            elsif temp.right != nil
            # 2 - our minimum has right subtree.
              temp.left = @right.left #12 <- 14 
              right_node = @right.right #14
              if right_node.data == temp.data
                right_node = temp.right #15
              else
                right_node.left = temp.right # 34 <- 40
              end
              temp.right = right_node #20 <- 32 -> 40
              @right = temp
            end
          end
        else
          @right.delete(data)
        end
      end
    end

  end

  def maximum() #this shit is only for deleting the fake node in the end, don't use for printing maximal value!
    unless @right.right.data
      return @right
    else
      return @right.maximum()
    end
  end
  
  def find(data)
    if @data == data
      return Node.new(@data, @left, @right)
    elsif data < @data
      if @left 
        return @left.find(data)
      else
        return 'No such node'
      end
    elsif data > @data
      if @right
        return @right.find(data)
      else
        return 'No such node'
      end
    end
  end

end

class Tree 
  attr_accessor :root

  def initialize(array)
    @root = create_tree(array, 0, array.length)
  end 
  
  def create_tree(array, anfang, ende)
    tree = build_tree(array, anfang, ende)
    tree.maximum().right = nil
    tree
  end

  def build_tree(array, anfang, ende)
    if anfang > ende 
      return nil 
    end

    mitte = (anfang + ende) / 2
    root = Node.new(array[mitte])

    root.set_left(build_tree(array, anfang, mitte - 1))
    root.set_right(build_tree(array, mitte + 1, ende))

    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data)
    @root.add_child(data)
  end

  def maximum()
    return @root.maximum()
  end

  def delete(data)
    # 3 cases:
    # deleting a leaf - if no left and no right
    @root.delete(data)
  end

  def find(data)
    @root.find(data)
  end

  def balanced?(root = @root, isBalanced = true)
    if root == nil || !isBalanced
      return 0, isBalanced
    end

    left_height, isBalanced = balanced?(root.left, isBalanced)
    right_height, isBalanced = balanced?(root.right, isBalanced)
 
    if (left_height - right_height).abs > 1
      isBalanced = false
    end
    return [left_height, right_height].max + 1, isBalanced
  end

  def rebalance()
    @root = Tree.new(inOrder(@root)).root
  end
end

def preOrder(node) #it is not important.
  if node == nil
    return
  end

  print node.data.to_s + ' '
  preOrder(node.left)
  preOrder(node.right)
end

def inOrder(node, array = []) # THIS is important. This array.
  if node == nil
    return
  end

  inOrder(node.left, array)
  array << node.data
  # print node.data.to_s + ' '
  inOrder(node.right, array)
  return array
end

numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
new_tree = Tree.new(numbers)

# Tree.new(inOrder(new_tree.root)).pretty_print()
new_tree.insert(4.5)
new_tree.pretty_print()

pp new_tree.balanced?
new_tree.rebalance()

new_tree.pretty_print()

#it worked. :)