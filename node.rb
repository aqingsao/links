class Node
  attr_reader :name
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
