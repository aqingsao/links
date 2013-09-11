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
  attr_reader :nodes
  def initialize(nodes)
    @nodes = nodes
  end
  def print_summary
    nodes_links = @nodes.each_with_object({}){|node, node_links| node_links[node]=[]}
    self.each do |link|
      nodes_links[link.node1] << link
      nodes_links[link.node2] << link
    end
    nodes_by_count = []
    nodes_links.each_pair do |node, links|
      nodes_by_count[links.length] = 0 if nodes_by_count[links.length].nil?
      nodes_by_count[links.length] = nodes_by_count[links.length] + 1
    end
    p nodes_by_count
  end
  def all_linked
    connected_nodes = self.each_with_object([]) do |link, connected_nodes|
      connected_nodes << link.node1 unless connected_nodes.include? link.node1
      connected_nodes << link.node2 unless connected_nodes.include? link.node2
    end
    connected_nodes.size >= @nodes.size 
  end
  def all_connected
    connected_nodes = self.each_with_object([]) do |link, connected_nodes|
      connected_nodes << link.node1 unless connected_nodes.include? link.node1
      connected_nodes << link.node2 unless connected_nodes.include? link.node2
    end
    connected_nodes.size >= @nodes.size 
  end
end