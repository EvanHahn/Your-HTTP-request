require "http/server"

server = HTTP::Server.new do |context|
  context.response.content_type = "text/plain"

  context.response.puts "Your HTTP request"
  context.response.puts

  context.response.puts "Version: #{context.request.version}"
  context.response.puts

  context.response.puts "Method: #{context.request.method}"
  context.response.puts

  context.response.puts "Headers:"
  context.response.headers.each do |header_name, header_values|
    header_values.each do |header_value|
      context.response.puts "  #{header_name}: #{header_value}"
    end
  end
end

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen
