class Node
  def initialize(name)
    @name = name
  end
  def to_s
    "node #{@name}"
  end
  def == (other)
    self.name == other.name
  end
end

class Link
  def initialize(node1, node2)
    @node1, @node2 = node1, node2
  end
  def ==(other)
    (self.node1 == other.node1 && self.node2 == other.node2) || (self.node1 == other.node2 && self.node2 == other.node1)
  end
  def Link.randomLink(nodes)
    index1 = rand(nodes.length);
    index2 = rand(nodes.length);
  end
end

nodes = 100.times.each_with_object([]) do |i, nodes|
  nodes << Node.new(i.to_s)
end

links = 100.times.each_with_object([]) do |i, links|
  
end