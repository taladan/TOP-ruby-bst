# node.rb
# This acts as a node for binary_search_tree algorithm

class Node
  attr_accessor :object, :left_branch, :right_branch, :root

  def initialize(object)
    @object = object
    @root = nil
    @left_branch = nil
    @right_branch = nil
  end

  def clear!
    @left_branch = nil
    @right_branch = nil
    @root = nil
    @object = nil
  end

  def leaf?
    # have to have a root and no children to be a leaf
    return true if !@root.nil? && @left_branch.nil? && @right_branch.nil?

    false
  end

  def number_of_children
    branches = [@left_branch, @right_branch]
    children = 0
    branches.each { |branch| children += 1 unless branch.nil? }
    children
  end
end
