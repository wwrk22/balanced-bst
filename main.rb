require_relative './lib/tree'

t = Tree.new(Array.new(15) { rand(1..100) })

t.print_tree
puts "balanced? = #{t.balanced?}"

puts "level order"
p t.level_order

puts "preorder"
p t.preorder

puts "inorder"
p t.inorder

puts "postorder"
p t.postorder

t.insert(101)
t.insert(102)
t.insert(103)

t.print_tree
puts "balanced? = #{t.balanced?}"

puts "rebalance"
t.rebalance
t.print_tree
puts "balanced? = #{t.balanced?}"

puts "level order"
p t.level_order

puts "preorder"
p t.preorder

puts "inorder"
p t.inorder

puts "postorder"
p t.postorder
