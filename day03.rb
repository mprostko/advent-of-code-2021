data = File.read('day03.input').split("\n")

zero_bits = Array.new(data.first.size, 0)
ones_bits = Array.new(data.first.size, 0)

data.each do |number|
  number.split('').each_with_index do |n, index|
    if n.to_i != 0
      ones_bits[index] += 1
    else
      zero_bits[index] += 1
    end
  end
end

puts "0: #{zero_bits.inspect}"
puts "1: #{ones_bits.inspect}"

gamma = ''
epsilon = ''
ones_bits.map.with_index do |val, index|
  gamma   << (ones_bits[index] > zero_bits[index] ? '1' : '0')
  epsilon << (ones_bits[index] > zero_bits[index] ? '0' : '1')
end

puts gamma.to_i(2) * epsilon.to_i(2)

puts '----'

def numcount0(arr, pos, override=nil) 
  zeroes = 0
  ones = 0
  arr.each do |bits|
    bits[pos].to_i == 0 ? zeroes += 1 : ones += 1
  end
  
  return override if override != nil && zeroes == ones 
  return zeroes > ones ? 0 : 1
end

def numcount1(arr, pos, override=nil) 
  zeroes = 0
  ones = 0
  arr.each do |bits|
    bits[pos].to_i == 0 ? zeroes += 1 : ones += 1
  end
  
  return override if override != nil && zeroes == ones 
  return zeroes < ones ? 0 : 1
end

index = 0
o2_data = data.dup
while(o2_data.size > 1)
  val = numcount0(o2_data, index, 1)
  o2_data = o2_data.select { |x| x[index] == val.to_s }
  index += 1
end 

index = 0
co2_data = data.dup
while(co2_data.size > 1)
  val = numcount1(co2_data, index, 0)
  co2_data = co2_data.select { |x| x[index] == val.to_s }
  index += 1
end 

puts o2_data.first.to_i(2) * co2_data.first.to_i(2)
