require 'graphviz'


GraphViz::parse('test.gv') do |g|
  puts 'G: ' + g.to_s
end

