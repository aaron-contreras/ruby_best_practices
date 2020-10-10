require_relative 'abstract_pre_and_post_processing'

server = Server.new

server.handle(/hello/i) { "Hey handsome! (from server at #{Time.now})" }
server.handle(/name is (\w+)/i) do |m|
  "Nice to meet you #{m[1]} (from server at #{Time.now}"
end
server.handle(/food/i) { "It's RAWWWWWW! (from server at #{Time.now})" }
server.handle(/bye/i) { "See ya! (from server at #{Time.now})" }
server.handle(/do/i) { "Here's a list of my features #{server.enlisted_commands}" }

server.run

