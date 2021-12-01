data = File.read('day01.input').split("\n").map(&:to_i)

puts data.each_cons(2).map { |a,b| b > a ? 1 : 0 }.sum

puts data.each_cons(4).map { |a,b,c,d| (b+c+d) > (a+b+c) ? 1 : 0 }.sum
