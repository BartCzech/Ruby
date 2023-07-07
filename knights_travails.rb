class Square
  attr_accessor :position
  def initialize(x, y)
    @position = []
    @position[0] = x
    @position[1] = y
  end
end

class Node
  attr_accessor :data, :children
  def initialize(square)
    @data = square.position
    @children = []
  end

  def find_root(node, root)
    return root.find(node)
  end

  def find(node) #flawed, multiple values
    if @data == node.data
      return true
    else
      i = 0
      while i < 8
        if children[i].nil? 
          break        
        else
          return children[i].find(node)
        end
      end
    end
    return
  end

  def add_children(root)
    x = @data[0]
    y = @data[1]
    if x + 2 < 9 && y + 1 < 9 && find_root(Node.new(Square.new(x + 2, y + 1)), root) != true then @children << Node.new(Square.new(x + 2, y + 1)) end
    if x + 1 < 9 && y + 2 < 9 && find_root(Node.new(Square.new(x + 1, y + 2)), root) != true then @children << Node.new(Square.new(x + 1, y + 2)) end
    if x - 1 > 0 && y + 2 < 9 && find_root(Node.new(Square.new(x - 1, y + 2)), root) != true then @children << Node.new(Square.new(x - 1, y + 2)) end
    if x - 2 > 0 && y + 1 < 9 && find_root(Node.new(Square.new(x - 2, y + 1)), root) != true then @children << Node.new(Square.new(x - 2, y + 1)) end
    if x - 2 > 0 && y - 1 > 0 && find_root(Node.new(Square.new(x - 2, y - 1)), root) != true then @children << Node.new(Square.new(x - 2, y - 1)) end
    if x - 1 > 0 && y - 2 > 0 && find_root(Node.new(Square.new(x - 1, y - 2)), root) != true then @children << Node.new(Square.new(x - 1, y - 2)) end
    if x + 1 < 9 && y - 2 > 0 && find_root(Node.new(Square.new(x + 1, y - 2)), root) != true then @children << Node.new(Square.new(x + 1, y - 2)) end
    if x + 2 < 9 && y - 1 > 0 && find_root(Node.new(Square.new(x + 2, y - 1)), root) != true then @children << Node.new(Square.new(x + 2, y - 1)) end

  #   i = 0
  #   while i < 8 #flawed, children being added only to the first child
  #     if @children[i].nil?
  #       break
  #     else
  #       return @children[i].add_children(root)
  #     end
  #     i += 1
  #   end
  #   return
  end

  def next_children(root)
    add_children(root)
  end

end

class Tree
  attr_accessor :root

  def initialize(node)
    @root = node
    @root.add_children(@root) #first_move
    @root.children[0].next_children(@root)
    @root.children[1].next_children(@root)
    @root.children[2].next_children(@root)
    @root.children[3].next_children(@root)
    @root.children[4].next_children(@root)
    
  end

end

zero_move = Node.new(Square.new(4, 4))
new_tree = Tree.new(zero_move)
pp new_tree.root.children

















# new_sq = Square.new(4, 4)
# new_node = Node.new(new_sq)

# pp new_node.data
# puts

# new_node.add_children()
# i = 0
# while true
#   if new_node.children[i].nil?
#     break
#   else
#     pp new_node.children[i].data
#   end
#   i += 1
# end
# puts