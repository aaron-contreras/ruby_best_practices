# frozen_string_literal: true

require 'socket'

class Client
  def initialize(ip = '127.0.0.1', port = 3333)
    @ip, @port = ip, port
  end

  def send_message(message)
    socket = TCPSocket.new(@ip, @port)
    socket.puts(message)
    response = socket.gets
  ensure
    socket.close
  end

  def receive_message
    socket = TCPSocket.new(@ip, @port)
    response = socket.gets
  ensure
    socket.close
  end

  # The issue here is that I've duplicated much of the same code for both
  # sending and receiveing a message as a client. I could abstract this
  # shared logic into private methods that both use, but the issue is that
  # the repetitive processes are not a single chunk of code... the variation
  # is in the MIDDLE. Here is where blocks come to the rescue
  
  def send_message(message)
    connection do |socket|
      socket.puts(message)
      socket.gets
    end
  end

  def receive_message
    connection { |socket| socket.gets }
  end

  private

  def connection
    socket = TCPSocket.new(@ip, @port)
    yield(socket)
  ensure
    socket.close
  end

  # By abstracting the creation and closing of a socket and yielding it
  # to the block given by other methods we have essentially made a connection
  # process almost infinitely flexible as long as we use connection giving
  # it a block.
  
  def tell_server_the_food_is_raw
    connection do |socket|
      socket.puts("It's RAWWWWWWWW!")
      socket.gets
    end
  end
end

class Server
  def initialize(port = 3333)
    @server = TCPServer.new('127.0.0.1', port)
    @handlers = {}
  end

  def self.run(port=3333, &block)
    server = self.new(port)
    server.instance_eval(&block)
    server.run
  end

  def handle(pattern, &block)
    @handlers[pattern] = block
  end

  def enlisted_commands
    @handlers.keys.join(', ')
  end

  def run
    while session = @server.accept
      msg = session.gets
      match = nil

      @handlers.each do |pattern, block|
        if match = msg.match(pattern)
          break session.puts(block.call(match))
        end
      end

      unless match
        session.puts "Server received unknown message #{msg}"
      end
    end
  end
end
