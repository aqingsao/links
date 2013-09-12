require File.join(File.dirname(__FILE__), "../link.rb")

describe Link do
  before (:each) do
    @node1 = Node.new(1)
    @node2 = Node.new(2)
    @node3 = Node.new(3)
    @node4 = Node.new(4)
  end

  describe "randomLink" do
    it "should generate a random link" do
      link = Link.randomLink [@node1, @node2]
      expect(link.node1).not_to eq(link.node2)
    end
  end
  describe 'all_linked' do 
    it "should return true" do
      links = Links.new([@node1, @node2]);
      links << Link.new(@node1, @node2)
      expect(links.all_linked).to be(true)
    end
    it "should return false" do
      links = Links.new([@node1, @node2]);
      expect(links.all_linked).to be(false)
    end
  end
  describe 'all_connected' do 
    it "should return false given some nodes have no links" do
      links = Links.new([@node1, @node2, @node3, @node4]);
      links << Link.new(@node1, @node2)
      expect(links.all_connected).to be(false)
    end
    it "should return false given all nodes have links but not connected together" do
      links = Links.new([@node1, @node2, @node3, @node4]);
      links << Link.new(@node1, @node2)
      links << Link.new(@node3, @node4)
      expect(links.all_connected).to be(false)
    end
    it "should return true given all nodes have links and are connected together" do
      links = Links.new([@node1, @node2, @node3, @node4]);
      links << Link.new(@node1, @node2)
      links << Link.new(@node1, @node3)
      links << Link.new(@node3, @node4)
      expect(links.all_connected).to be(true)
    end
  end
end