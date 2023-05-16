require_relative './lib/tree'

tree = Tree.new([1, 2, 3, 4, 5, 6])
tree.print_tree(true)
puts

short_tree = Tree.new([1])
short_tree.print_tree
puts

empty_tree = Tree.new([])
empty_tree.print_tree
puts

tall_tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
tall_tree.print_tree
puts
