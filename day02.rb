data = File.read('day02.input').split("\n")

depth = 0
position = 0

data.each.map do |line|
  dir, val = line.split(' ')
  case dir
  when 'forward'
    position += val.to_i
  when 'up'
    depth -= val.to_i
  when 'down'
    depth += val.to_i
  end
end

puts depth * position

depth = 0
position = 0
aim = 0

data.each.map do |line|
  dir, val = line.split(' ')
  case dir
  when 'forward'
    position += val.to_i
    depth += aim * val.to_i
  when 'up'
    aim -= val.to_i
  when 'down'
    aim += val.to_i
  end
end

puts depth * position