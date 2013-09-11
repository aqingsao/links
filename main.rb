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
  link = Link.randomLink(nodes) while link.nil? || links.include?(link)
  links << link
  links.print_summary if(links.size % 100 == 0)
end until links.all_linked

p "nodes: #{nodes.length}, links: #{links.length}"
links.print_summary
