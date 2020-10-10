# frozen_string_literal: true

class SortedList
  include Enumerable

  def initialize
    @data = []
  end

  def <<(element)
    (@data << element).sort!
  end

  def each
    @data.each { |e| yield(e) }
  end

  def map
    @data.map { |e| yield(e) }
  end

  def inject(obj)
    @data.inject(obj) { |a, b| yield(a, b) }
  end
  
  def to_a
    @data.to_a
  end

  def select
    @data.select { |e| yield(e) }
  end

  def report(head)
    header = "#{head}\n#{'-' * head.length}"
    body = map { |e| yield(e) }.join("\n") + "\n"
    footer = "This report was generated at #{Time.now}\n"
    [header, body, footer].join("\n")
  end
end

