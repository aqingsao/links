require File.join(File.dirname(__FILE__), "../link.rb")

describe Link do
  before (:each) do
    @nodes = [Node.new(1), Node.new(2)]
  end

  describe "randomLink" do
    it "should generate a random link" do
      link = Link.randomLink @nodes
      expect(link.node1).not_to eq(link.node2)
    end
  end
end