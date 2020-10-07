# frozen_string_literal: true

class LockBox

  UnauthorizedAccess = Class.new(StandardError)
  InvalidPassword = Class.new(StandardError)

  def initialize(options)
    @locked = true
    @password = options[:password]
    @content = options[:content]
  end

  def unlock(password)
    @password == password ? @locked = false : raise(InvalidPassword)
  end

  def content
    @locked ? raise(UnauthorizedAccess) : @content
  end
end

