# binary_search_tree.rb
# frozen_string_literal: true

require_relative 'node'

# Binary Search Tree
class BinarySearchTree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def root_value
    @root.value
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_branch, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_branch
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.object}"
    pretty_print(node.left_branch, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_branch
  end

  def insert(value, current_node = @root)
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
      current_node
    end
  end

  def find(value, current_node = @root)
    return current_node if current_node.nil?
    return current_node if current_node.object == value

    if value < current_node.object
      find(value, current_node.left_branch)
    elsif value > current_node.object
      find(value, current_node.right_branch)
    else
      raise 'Not found'
    end
  end

  def delete(value, node = @root)
    return node if node.nil?

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
    node
  end

  def count(node = @root)
    return 0 if node.nil?

    left = count(node.left_branch)
    right = count(node.right_branch)
    1 + left + right
  end

  def tree_height(node = @root)
    return 0 if node.nil?

    left_branch_height = tree_height(node.left_branch)
    right_branch_height = tree_height(node.right_branch)
    [left_branch_height, right_branch_height].max + 1
  end

  def depth(value, node = @root, count = 0)
    return node if node.nil?

    search = value.instance_of?(Node) ? value : find(value)
    return search if search.nil?
    return count += 1 if search == node

    left = depth(search, node.left_branch, count + 1)
    right = depth(search, node.right_branch, count + 1)
    left || right
  end

  def balanced?(node = @root)
    return true if node.nil?

    lh = balance_height(node.left_branch)
    rh = balance_height(node.right_branch)

    return true if ((lh - rh).abs <= 1) &&
                   balanced?(node.left_branch) &&
                   balanced?(node.right_branch)

    false
  end

  def rebalance
    return nil if balanced?

    nodes = print_tree_inorder
    BinarySearchTree.new(nodes)
  end

  def print_tree_level_order(node = @root, output = [], &block)
    return node if node.nil?

    height = tree_height(@root)
    level = 0
    while level < height
      print_level(node, level, output, &block)
      level += 1
    end
    output.compact
  end

  def print_tree_inorder(node = @root, output = [], &block)
    return node if node.nil?

    print_tree_inorder(node.left_branch, output, &block)
    if block_given?
      output << node.object if block.call(node.object)
    elsif node
      output << node.object
    end
    print_tree_inorder(node.right_branch, output, &block)
    output
  end

  def print_tree_preorder(node = @root, output = [], &block)
    return node if node.nil?

    if block_given?
      output << node.object if block.call(node.object)
    elsif node
      output << node.object
    end
    print_tree_preorder(node.left_branch, output, &block)
    print_tree_preorder(node.right_branch, output, &block)
    output
  end

  def print_tree_postorder(node = @root, output = [], &block)
    return node if node.nil?

    print_tree_postorder(node.left_branch, output, &block)
    print_tree_postorder(node.right_branch, output, &block)
    if block_given?
      output << node.object if block.call(node.object)
    else
      output << node.object
    end

    output
  end

  private

  def balance_height(node)
    return 0 if node.nil?

    left = balance_height(node.left_branch)
    right = balance_height(node.right_branch)
    [left, right].max + 1
  end

  def print_level(node, level, output = [], &block)
    return node if node.nil?

    if level.zero? && block_given?
      output << node.object if block.call(node.object)
    elsif level.zero?
      output << node.object
    else
      print_level(node.left_branch, level - 1, output, &block)
      print_level(node.right_branch, level - 1, output, &block)
    end
  end

  def find_right_branch_min(node)
    return node if node.left_branch.nil?

    find_right_branch_min(node.left_branch)
  end

  def build_tree(array, start = 0, stop = array.length, current_node = @root)
    mid = (start + stop) / 2
    return nil if start == array.length
    return nil if start > stop

    node = create_node(array[mid])
    node.root = current_node
    node.left_branch = build_tree(array, start, mid - 1, node)
    node.right_branch = build_tree(array, mid + 1, stop, node)
    node
  end

  def create_node(object)
    Node.new(object)
  end
end
