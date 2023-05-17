require_relative './lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.print_tree

puts "Insert 2"
tree.insert(2)
tree.print_tree

puts "Insert 200"
tree.insert(200)
tree.print_tree

puts "Insert 6"
tree.insert(6)
tree.print_tree

puts "Delete 2"
tree.delete(2)
tree.print_tree

puts "Delete 4"
tree.delete(4)
tree.print_tree

puts "Delete 8"
tree.delete(8)
tree.print_tree

puts "Level order print"
tree.level_order { |node| print node.data.to_s + ' ' }
puts
