# Game Board and a Knight
class ChessBoard
  def initialize
    # @spaces = []
    # for i in 0..7
    #   @spaces.push([])
    #   for j in 0..7
    #     @spaces[i][j] = j
    #   end
    # end
  end

  # def print_board
  #   @spaces.each {|row| p row}
  # end

  def knight_moves(current_pos, new_pos)
    knight = Knight.new(current_pos)
    knight.level_order_search(new_pos)
  end
end

class Knight
  # Similar to a tree

  def initialize(position=[3,3])
    @position=position
    @root = build_knight_tree
  end

  attr_accessor :position

  def off_board(position)
    x = position[0]
    y = position[1]
    if x < 0 || x > 7
      return true
    elsif y < 0 || y > 7
      return true
    end
    return false
  end

  def build_knight_tree(position=@position, x=0, y=0, moves=0)

    position = [position[0]+x, position[1]+y]
    moves += 1
  
    return nil if off_board(position)
    return nil if moves >= 6

    root = Node.new(position)

    root.forward2right1 = build_knight_tree(position, 1, 2, moves)
    root.forward1right2 = build_knight_tree(position, 2, 1, moves)
    root.forward2left1 = build_knight_tree(position, -1, 2, moves)
    root.forward1left2 = build_knight_tree(position, -2, 1, moves)
    root.backward2right1 = build_knight_tree(position, 1, -2, moves)
    root.backward1right2 = build_knight_tree(position, 2, -1, moves)
    root.backward2left1 = build_knight_tree(position, -1, -2, moves)
    root.backward1left2 = build_knight_tree(position, -2, -1, moves)
    # p root.position
    return root
  end



  def level_order_search(search_position, queue=[@root], path=[])
    
    # NEED TO FIGURE OUT HOW TO PRINT ONLY THE REAL PATH, NOT EVERY ITEM LOOKED AT
    
    curr = queue.shift
    puts "Current Item in Queue: #{curr}"

    path.push(curr.position)
    puts "Current Path: #{path}"

    return path if curr.position == search_position
    queue << curr.forward2right1 if curr.forward2right1 != nil
    queue << curr.forward1right2 if curr.forward1right2 != nil
    queue << curr.forward2left1 if curr.forward2left1 != nil
    queue << curr.forward1left2 if curr.forward1left2 != nil
    queue << curr.backward2right1 if curr.backward2right1 != nil
    queue << curr.backward1right2 if curr.backward1right2 != nil
    queue << curr.backward2left1 if curr.backward2left1 != nil
    queue << curr.backward1left2 if curr.backward1left2 != nil
    level_order_search(search_position, queue, path)
  end

end

class Node
  def initialize(position)
    @position = position
    @x = position[0]
    @y = position[1]
    @forward2right1 = nil
    @forward1right2 = nil
    @forward2left1 = nil
    @forward1left2 = nil
    @backward2right1 = nil
    @backward1right2 = nil
    @backward2left1 = nil
    @backward1left2 = nil
  end

  attr_accessor :forward2right1, :forward1right2, :forward2left1, :forward1left2
  attr_accessor :backward2right1, :backward1right2, :backward2left1, :backward1left2
  attr_reader :position

end

my_game = ChessBoard.new()
# my_game.print_board
my_game.knight_moves([3,3],[4,3])






# Build tree of potential knight moves

# Decide on search algorithm
# Breadth first? or Depth First?

# Find shortest path between starting square / node and ending square
# Output the full path
