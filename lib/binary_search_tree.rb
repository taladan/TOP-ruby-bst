# binary_search_tree.rb
require_relative "node"

class BinarySearchTree 
  attr_accessor :root
  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end
  
  def root_value 
    return @root.value
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_branch, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_branch
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.object}"
    pretty_print(node.left_branch, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_branch
  end
  
  def insert_node(array, current_node=@root)
    midpoint = array.length/2
    left = array[0..midpoint]
    right = array[midpoint + 1..-1]
    create_child(node) if current_node.leaf?
    if !left_branch.nil? && get_midpoint_value(left) < current_node.value
      insert_node(left, node)
    elsif !right_branch.nil? && get_midpoint_value(right) > current_node.value
      insert_node(right, node)
    else
      return node
    end
  end

  private

  require "pry-byebug"
  def build_root(array)
    binding.pry
    node = create_node(get_midpoint_value(array))
    left = array[0..get_midpoint(array)]
    right = array[get_midpoint(array) + 1..-1]
    left_node = create_node(get_midpoint_value(left)) 
    right_node = create_node(get_midpoint_value(right)) 
    node.left_branch = left_node
    node.right_branch = right_node
    left_node.root = node
    right_node.root = node
    return node
  end

  def get_midpoint_value(array)
    return array[get_midpoint(array)]
  end
  
  def get_midpoint(array)
    return array.length/2
  end

  def create_child(node, current_node)
    case node.value <=> current_node.value
    when -1
      current_node.left_branch = node
    when 0
      return nil
    when 1
      current_node.right_branch = node
    end
  end

  def build_tree(array)
    return nil if array.empty?
    @root = build_root(array)
    # insert_node(array, @root)
    return @root
  end

  def create_node(object)
    Node.new(object)
  end
end