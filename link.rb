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
    index2 = rand(nodes.length) while index2.nil? || index2 == index1;
    Link.new(nodes[index1], nodes[index2])
  end
  def to_s
    "Link(#{@node1.name}-#{@node2.name})"
  end
end

class Links < Array
  def print_summary
    nodes_links = {}
    self.each do |link|
      nodes_links[link.node1] = [] if nodes_links[link.node1].nil?
      nodes_links[link.node2] = [] if nodes_links[link.node2].nil?
      nodes_links[link.node1] << link
      nodes_links[link.node2] << link
    end
    p nodes_links.length
    nodes_links.each_pair do |node, links|
      p "#{node}: #{links.length}"
    end
  end
end