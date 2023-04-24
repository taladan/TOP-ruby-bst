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

  def find(value, current_node=@root)
    return current_node if current_node.nil?
    return current_node if current_node.object == value
    if value < current_node.object
      find(value, current_node.left_branch)
    elsif value > current_node.object
      find(value, current_node.right_branch)
    else
      raise "Not found"
    end
  end
  

  def delete(value, node=@root)
    return node if node.nil?
    
    root = node.root

    if value < node.object
      node.left_branch = delete(value, node.left_branch)
    elsif value > node.object
      node.right_branch = delete(value, node.right_branch)
    else
      return nil if node.leaf?
      if node.left_branch.nil?        
        temp = node.right_branch
        node.clear!
        return temp
      elsif node.right_branch.nil?
        temp = node.left_branch
        node.clear!
        return temp
      else
        temp = find_right_branch_min(node.right_branch)
        node.object = temp.object 
        node.right_branch = delete(temp.object, node.right_branch)
      end
    end
    return node
  end

  def count(node=@root)
    return 0 if node.nil? 
    left = count(node.left_branch)
    right = count(node.right_branch)
    return 1 + left + right
  end
         
  def tree_height(node=@root)
    return 0 if node.nil?
    left_branch_height = height(node.left_branch)
    right_branch_height = height(node.right_branch)
    return [left_branch_height, right_branch_height].max + 1
  end

  def print_tree_level_order(node=@root)
    height = tree_height(@root)
    level = 0
    while level < height
      print_level(node, level)
      level += 1
    end
    print "\n"
  end

  private
  
  def print_level(node, level)
    return if node.nil?
    if level == 0
      print "#{node.object} "
    else
      print_level(node.left_branch, level-1)
      print_level(node.right_branch, level-1)
    end
  end
  
  def preorder()
    # root
    # left_branch
    # right_branch
  end
  
  def inorder(node)
    # inorder(node.left_branch)
    # root
    # right_branch
  end
  
  def postorder()
    # left_branch
    # right_branch
    # root
  end
  
  def find_right_branch_min(node)
    return node if node.left_branch.nil?
    find_right_branch_min(node.left_branch)
  end

  def build_tree(array, start=0, stop=array.length, current_node=@root)
    mid = (start + stop)/2
    return nil if start == array.length
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