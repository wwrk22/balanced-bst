require_relative './lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.print_tree

puts "Insert 2"
tree.insert(2)
tree.print_tree

puts "Insert 200"
tree.insert(200)
tree.print_tree
