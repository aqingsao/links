require File.join(File.dirname(__FILE__), "graph.rb")
require File.join(File.dirname(__FILE__), "link.rb")

link_factor = 1
node_count = 1000

nodes = node_count.times.each_with_object([]) do |i, nodes|
  nodes << Node.new(i.to_s)
end

links = (nodes.length * link_factor).to_i.times.each_with_object(Links.new(nodes)) do |i, links|
  link = Link.randomLink(nodes) while link.nil? || links.include?(link)
  links << link
end
p "nodes: #{nodes.length}, links: #{links.length}"
links.print_summary

begin
  ([nodes.size / 100, 1].max).to_i.times do |i|
    link = Link.randomLink(nodes) while link.nil? || links.include?(link)
    links << link
  end
end until links.all_linked

links.print_summary