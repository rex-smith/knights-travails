# Game Board and a Knight
class ChessBoard

  def knight_moves(current_pos, new_pos)
    knight = Knight.new(current_pos)
    parent_array = knight.find_parents(knight.find_node(new_pos))
    parent_array.reverse.each_with_index {|position, index| puts "Move #{index}: #{position}"}
    puts
  end
end

class Knight

  def initialize(position=[3,3])
    @position = position
    MoveNode.class_variable_set(:@@history, [])
    @root = build_knight_tree
    
  end

  attr_accessor :position, :root

  def build_knight_tree
    root = MoveNode.new(@position)
    return root
  end

  def find_node(search_position)
    queue = []
    current_node = self.root
    until current_node.position == search_position
      current_node.children.each { |child| queue.push(child)}
      current_node = queue.shift
    end
    return current_node
  end

  def find_parents(node, path=[node.position])
    # Prints out the list of parents of a position starting with the root node
    parent_position = node.parent.position
    path << parent_position
    return path if node.parent == self.root
    find_parents(node.parent, path) unless node.parent.nil?
  end

end

class MoveNode
  @@history = []

  def initialize(position, parent=nil)
    @position = position
    @parent = parent
    @@history.push(position)
  end

  def inspect
    return "Node at #{@position} with parent #{@parent.position}"
  end

  attr_accessor :position, :children, :parent, :history

  MOVES = [[1, 2], [-2, -1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  def self.valid?(position)
    position[0].between?(1,8) && position[1].between?(1,8)
  end

  def children
    # Creates children from valid moves

    children = MOVES.map { |move| [@position[0] + move[0], @position[1] + move[1]]}
    .keep_if {|location| MoveNode.valid?(location)}
    .reject {|location| @@history.include?(location)}
    .map {|position| MoveNode.new(position, self)}
    # p children
    return children
  end
end

# Testing

my_game = ChessBoard.new()
my_game.knight_moves([3,3],[4,3])
my_game.knight_moves([6,2],[8,1])
my_game.knight_moves([6,5],[1,1])