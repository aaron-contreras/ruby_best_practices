def distance(x1, y1, x2, y2)
  Math.hypot(x2 - x1, y2 - y1)
end

def load_file(name, mode='rb')
  File.open(name, mode)
end

def load_file2(name='example_args.rb', mode='rb')
  File.open(name, mode)
end

