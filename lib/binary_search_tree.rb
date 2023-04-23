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
  
  def insert()

  end

  private

  require "pry-byebug"
  def build_tree(array, start=0, stop=array.length)
    # binding.pry
    mid = (start + stop)/2
    return nil if start > stop
    root = create_node(array[mid])
    root.left_branch = build_tree(array, start, mid-1)
    root.right_branch = build_tree(array, mid+1, stop)
    return root
  end

  # def build_branch(array)
  #   binding.pry
  #   node = create_node(get_midpoint_value(array))
  #   left = array[0..get_midpoint(array)]
  #   right = array[get_midpoint(array) + 1..-1]
  #   left_node = create_node(get_midpoint_value(left)) 
  #   right_node = create_node(get_midpoint_value(right)) 
  #   left_node.root = node
  #   right_node.root = node
  #   node.left_branch = build_branch(left)
  #   node.right_branch = build_branch(right)
  #   return node
  # end

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


  def create_node(object)
    Node.new(object)
  end
end