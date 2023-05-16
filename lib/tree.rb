class Tree
  attr_reader :root

  def initialize(array)
    @array = array
    build_tree
  end

  def build_tree
    build_branch(0, @array.length - 1)
  end

  private

  def build_branch(start_index, end_index
    return nil if start_index > end_index

    mid_index = (start_index + end_index) / 2
    curr_root = Node.new(@array(mid_index))
    curr_root.left_child = build_branch(start_index, mid_index - 1)
    curr_root.right_child = build_branch(mid_index + 1, end_index)

    return curr_root
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
