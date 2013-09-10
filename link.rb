require File.join(File.dirname(__FILE__), "node.rb")

class Link
  attr_reader :node1, :node2
  def initialize(node1, node2)
    @node1, @node2 = node1, node2
  end
  def ==(other)
    (self.node1 == other.node1 && self.node2 == other.node2) || (self.node1 == other.node2 && self.node2 == other.node1)
  end
  def Link.randomLink(nodes)
    index1 = rand(nodes.length);
    index2 = rand(nodes.length);
    Link.new(nodes[index1], nodes[index2])
  end
end
