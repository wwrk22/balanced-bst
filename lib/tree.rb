class Tree
  def initialize(array)
    @array = array
    set_root
  end

  def set_root
    @root = Node.new(@array[mid_index(@array)]) if @array.size > 0
  end

  def build_tree
    curr_root = @array[mid_index(@array)]
    
  end

  private

  # Return the middle index of the given array.
  # Return -1 if the array is empty.
  def mid_index(array)
    return (0 + array.length - 1) / 2
  end

  def pp_right_args(node, prefix, is_left)
    [node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false]
  end

  def pp_left_args(node, prefix, is_left)
    [node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true]
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(pp_right_args(node, prefix, is_left)) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(pp_left_args(node, prefix, is_left) if node.left
  end
end
