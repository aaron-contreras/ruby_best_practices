require_relative 'abstract_pre_and_post_processing'

client = Client.new

["Hello", "My name is Aaron", "How's the food?", "Byebye",
 'What do you respond to?'].each do |message|
  response = client.send_message(message)
  puts response
end
