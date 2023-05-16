class Node
  include Comparable

  attr_accessor :left_child, :right_child
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def <=>(other_node)
    @data <=> other_node.data
  end
end
