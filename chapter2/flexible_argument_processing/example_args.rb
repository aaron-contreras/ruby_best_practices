def distance(x1, y1, x2, y2)
  Math.hypot(x2 - x1, y2 - y1)
end

def distance2(*points)
  distance(*points.flatten)
end

def distance3(*points)
  case(points.length)
  when 2
    x1, y1, x2, y2 = points.flatten
  when 4
    x1, y1, x2, y2 = points
  else
    raise ArgumentError,
      'Points may be specified as [x1, y1], [x2, y2] or x1, y1, x2, y2'
  end

  Math.hypot(x2 - x1, y2 - y1)
end


# Using #is_a? instead of === based on style guide
def distance4(*points)
  x1, y1, x2, y2 = points.flatten
  raise ArgumentError unless [x1, y1, x2, y2].all? { |e| e.is_a? Numeric }
  Math.hypot(x2 - x1, y2 - y1)
end

def load_file(name, mode='rb')
  File.open(name, mode)
end

def load_file2(name='example_args.rb', mode='rb')
  File.open(name, mode)
end

# Pseudo-keyword arguments
def story(options)
  "#{options[:person]} went to town, riding on a #{options[:animal]}"
end

def story_improved(options={})
  options = { person: 'Yankee Doodle', animal: 'Tiger' }.merge(options)
  "#{options[:person]} went to to town, riding on a #{options[:animal]}"
end

def write_story_to_file(file, options={})
  File.open(file, 'w') { |f| f << story_improved(options) }
end

