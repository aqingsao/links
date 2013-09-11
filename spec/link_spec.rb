require File.join(File.dirname(__FILE__), "../link.rb")

describe Link do
  before (:each) do
    @node1 = Node.new(1)
    @node2 = Node.new(2)
  end

  describe "randomLink" do
    it "should generate a random link" do
      link = Link.randomLink [@node1, @node2]
      expect(link.node1).not_to eq(link.node2)
    end
  end
  describe 'all_connected' do 
    it "should return true" do
      links = Links.new([@node1, @node2]);
      links << Link.new(@node1, @node2)
      expect(links.all_connected).to be(true)
    end
    it "should return false" do
      links = Links.new([@node1, @node2]);
      expect(links.all_connected).to be(false)
    end
  end
end