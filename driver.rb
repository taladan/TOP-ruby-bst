# Driver script for binary search tree exercise
# frozen_string_literal: true

require './lib/binary_search_tree'

# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
test_array = Array.new(15) { rand(1..100) }
tree = BinarySearchTree.new(test_array)

# Confirm that the tree is balanced by calling #balanced?
puts "Is the tree balanced? #{tree.balanced?}"
# Print out all elements in level, pre, post, and in order
puts 'Element orders:'
puts "Tree level order: #{tree.print_tree_level_order}"
puts "Preorder: #{tree.print_tree_preorder}"
puts "Postorder: #{tree.print_tree_postorder}"
puts "Inoder: #{tree.print_tree_inorder}"
puts "\n"
# Unbalance the tree by adding several numbers > 100
puts "Unbalancing Tree:\n"
(101..125).to_a.each { |element| tree.insert(element) }
# Confirm that the tree is unbalanced by calling #balanced?
puts tree.pretty_print
puts "Checking tree balance (unbalanced should be false) #{tree.balanced?}"
# Balance the tree by calling #rebalance
puts 'Rebalancing tree'
tree = tree.rebalance
# Confirm that the tree is balanced by calling #balanced?
puts "Tree should be rebalanced: #{tree.balanced?}"
puts 'Rebalanced tree:'
puts tree.pretty_print
# Print out all elements in level, pre, post, and in order
puts 'New element orders:'
puts "Tree level order: #{tree.print_tree_level_order}"
puts "Preorder: #{tree.print_tree_preorder}"
puts "Postorder: #{tree.print_tree_postorder}"
puts "Inoder: #{tree.print_tree_inorder}"
