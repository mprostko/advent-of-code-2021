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

puts gamma
puts epsilon

puts gamma.to_i(2) * epsilon.to_i(2)

o2r = ''
co2r = ''
data = data.map { |x| x.to_i(2) }
index = zero_bits.size
o2r_mask = 0
while(index > 0) do
  index -= 1
  o2_bit = ones_bits.reverse[index] > zero_bits.reverse[index] ? 1 : 0
  o2r_mask = o2r_mask | (o2_bit << index)
  puts "BIT: #{o2_bit}, mask: #{o2r_mask.to_s(2).ljust(5,'*')}, T: #{data.map{|x| x.to_s(2).rjust(5, '0') }.join(', ')}"
  data.delete_if { |x| ~x ^ (o2r_mask) == 0 }
end
puts data.inspect


