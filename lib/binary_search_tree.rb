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
  
  def insert(value, current_node=@root)
    direction = value <=> current_node.object
    
    if current_node.leaf?
      case direction
      when -1
        current_node.left_branch = create_node(value)
        current_node.left_branch.root = current_node
        output = current_node
      when 0
        output = current_node
      when 1
        current_node.right_branch = create_node(value)
        current_node.right_branch.root = current_node
        output = current_node
      end
      return output
    end
    
    if value < current_node.object && current_node.left_branch.nil?
      current_node.left_branch = create_node(value)
      current_node.left_branch.root = current_node
    elsif value < current_node.object && !current_node.left_branch.nil?
      insert(value, current_node.left_branch)
    elsif value > current_node.object && current_node.right_branch.nil?
      current_node.right_branch = create_node(value)
      current_node.right_branch.root = current_node
    elsif value > current_node.object && !current_node.right_branch.nil?
      insert(value, current_node.right_branch)
    elsif value == current_node.object
      return current_node  
    end
  end

  private

  def build_tree(array, start=0, stop=array.length, current_node=@root)
    mid = (start + stop)/2
    return nil if start > stop
    root = create_node(array[mid])
    root.root = current_node
    root.left_branch = build_tree(array, start, mid-1, root)
    root.right_branch = build_tree(array, mid+1, stop, root)
    return root
  end

  def create_node(object)
    Node.new(object)
  end
end