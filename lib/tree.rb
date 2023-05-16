require_relative './node'

class Tree
  attr_reader :root

  def initialize(array)
    @array = array.uniq.sort
    build_tree
  end

  def build_tree
    @root = build_branch(0, @array.length - 1)
  end

  def find(data, root_node = @root)
    return root_node if root_node.nil? || root_node.data == data
    return find(data, root_node.left_child) if data < root_node.data
    return find(data, root_node.right_child) # data > root_node.data
  end

  def insert(data)
    return false if find(data)
    @root = Node.new(data) if @root.nil?
    insert_at(data)
    return true
  end

  def print_tree(include_array=true)
    return puts "Tree is empty" if @array.size == 0
    p @array if include_array
    pretty_print
  end
    
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(*pp_right_args(node, prefix, is_left)) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(*pp_left_args(node, prefix, is_left)) if node.left_child
  end

  private

  def build_branch(start_index, end_index)
    return nil if start_index > end_index
    return build_branch_recursion(start_index, end_index)
  end

  def build_branch_recursion(start_index, end_index)
    mid_index = (start_index + end_index) / 2
    curr_root = Node.new(@array[mid_index])
    curr_root.left_child = build_branch(start_index, mid_index - 1)
    curr_root.right_child = build_branch(mid_index + 1, end_index) 
    return curr_root
  end

  def pp_left_args(node, prefix, is_left)
    [node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true]
  end

  def pp_right_args(node, prefix, is_left)
    [node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false]
  end

  def insert_at(data, root_node = @root)
    if data < root_node.data
      insert_at_left_child(data, root_node)
    else
      insert_at_right_child(data, root_node)
    end
  end

  def insert_at_left_child(data, root_node)
    if root_node.left_child.nil?
      root_node.left_child = Node.new(data)
    else
      insert_at(data, root_node.left_child)
    end
  end

  def insert_at_right_child(data, root_node)
    if root_node.right_child.nil?
      root_node.right_child = Node.new(data)
    else
      insert_at(data, root_node.right_child)
    end
  end
end
