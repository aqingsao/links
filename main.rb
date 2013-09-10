require File.join(File.dirname(__FILE__), "link.rb")

link_factor = 1.5

nodes = 100.times.each_with_object([]) do |i, nodes|
  nodes << Node.new(i.to_s)
end


links = (nodes.length * link_factor).to_i.times.each_with_object(Links.new) do |i, links|
  link = Link.randomLink(nodes) while link.nil? || links.include?(link)
  links << link
end

p "nodes: #{nodes.length}"
p "links factor: #{link_factor}, links: #{links.length}"
links.print_summary