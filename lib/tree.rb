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

  def depth(data)
    return -1 if find(data).nil?
    return compute_depth(data)
  end

  def insert(data)
    return false if find(data)
    @root = Node.new(data) if @root.nil?
    insert_at(data)
    return true
  end

  def delete(data)
    @array.delete(data)
    @root = delete_node(data)
  end

  def level_order(&node_proc)
    q = []
    q << @root if @root
    level_order_array = []
    process_q(q, level_order_array, node_proc)
    return level_order_array
  end

  def inorder(root_node = @root, &node_proc)
    inorder_array = []
    inorder_traversal(root_node, inorder_array, node_proc)
    return inorder_array
  end

  def preorder(root_node = @root, &node_proc)
    preorder_array = []
    preorder_traversal(root_node, preorder_array, node_proc)
    return preorder_array
  end

  def postorder(root_node = @root, &node_proc)
    postorder_array = []
    postorder_traversal(root_node, postorder_array, node_proc)
    return postorder_array
  end

  def balanced?(root_node = @root)
    return true if root_node.nil?
    return subtree_balanced?(root_node)
  end

  def rebalance
    return if balanced?
    @array.clear
    inorder { |node| @array << node.data }
    build_tree
  end

  def height(root_node = @root)
    return 0 if root_node.nil?
    left_height = height(root_node.left_child)
    right_height = height(root_node.right_child)
    return (left_height > right_height) ? 1 + left_height : 1 + right_height
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

  def delete_node(data, root_node = @root)
    return nil if root_node.nil? # Empty tree

    if root_node.data == data
      root_node = replace_node(root_node)
    else # Not a match
      delete_at_children(data, root_node)
    end

    return root_node
  end

  def replace_node(root_node)
    if root_node.left_child.nil? && root_node.right_child.nil?
      return nil
    else # Parent node
      return replace_with_successor(root_node)
    end
  end

  def delete_at_children(data, root_node)
    if data < root_node.data
      root_node.left_child = delete_node(data, root_node.left_child)
    else # data > root_node.data
      root_node.right_child = delete_node(data, root_node.right_child)
    end
  end

  def replace_with_successor(root_node)
    if root_node.right_child.nil?
      return root_node.left_child
    else
      return right_subtree_succession(root_node)
    end
  end

  def right_subtree_succession(root_node)
    successor = root_node.right_child
    successor = successor.left_child until successor.left_child.nil?
    root_node.data = successor.data
    root_node.right_child = delete_node(successor.data, root_node.right_child)
    return root_node
  end

  def process_q(q, level_order_array, node_proc)
    until q.empty? do
      node = q.shift
      level_order_array << node.data
      node_proc.call node if node_proc
      q << node.left_child if node.left_child
      q << node.right_child if node.right_child
    end
  end

  def inorder_traversal(root_node, inorder_array, node_proc)
    return if root_node.nil?
    inorder_traversal(root_node.left_child, inorder_array, node_proc)
    node_proc.call root_node if node_proc
    inorder_array << root_node.data
    inorder_traversal(root_node.right_child, inorder_array, node_proc)
  end

  def preorder_traversal(root_node, preorder_array, node_proc)
    return if root_node.nil?
    node_proc.call root_node if node_proc
    preorder_array << root_node.data
    preorder_traversal(root_node.left_child, preorder_array, node_proc)
    preorder_traversal(root_node.right_child, preorder_array, node_proc)
  end

  def postorder_traversal(root_node, postorder_array, node_proc)
    return if root_node.nil?
    postorder_traversal(root_node.left_child, postorder_array, node_proc)
    postorder_traversal(root_node.right_child, postorder_array, node_proc)
    node_proc.call root_node if node_proc
    postorder_array << root_node.data
  end

  def compute_depth(data, root_node = @root)
    return 0 if root_node.data == data
    left_subtree = root_node.left_child
    right_subtree = root_node.right_child
    return 1 + compute_depth(data, left_subtree) if data < root_node.data
    return 1 + compute_depth(data, right_subtree) if data > root_node.data
  end

  def subtree_balanced?(root_node)
    left_height = height(root_node.left_child)
    right_height = height(root_node.right_child)
    left_balanced = balanced?(root_node.left_child)
    right_balanced = balanced?(root_node.right_child)
    return height_diff(left_height, right_height) <= 1 && left_balanced && right_balanced
  end

  def height_diff(a, b)
    (a - b).abs
  end
end
