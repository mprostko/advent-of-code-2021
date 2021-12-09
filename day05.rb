data = File.read('day05.input').split("\n").map{ |line| line.split(' -> ').map { |coords| coords.split(',').map(&:to_i) } }

class Point
	attr_accessor :x, :y
	def initialize(x,y)
		@x = x
		@y = y
	end
	def to_s
		"(#{x}, #{y})"
	end
	def ==(pt)
		x == pt.x && y == pt.y
	end
	def to_key
		to_s.sub(' ', '')
	end
end

def compute(p1, p2)
	x1 = p1.x
	y1 = p1.y
	x2 = p2.x
	y2 = p2.y

	if (x1 != x2)
		#return [] if (y1 != y2) # uncomment for 1 star

		a = (y2 - y1).to_f / (x2 - x1).to_f
		b = (y1) - a * x1

		xx = [x1, x2].sort

		return xx[0].upto(xx[1]).map do |xx|
			y = (a*xx + b).round
			Point.new(xx,y)
		rescue
			next # skip if number is not computable
		end.compact
	else
		yy = [y1, y2].sort
		return yy[0].upto(yy[1]).map do |yy|
			Point.new(x1, yy)
		end
	end
end


lines = []

data.each do |line|
	line.each_slice(2) do |p1, p2|
	  p1 = Point.new(*p1.map(&:to_i))
		p2 = Point.new(*p2.map(&:to_i))

		lines << [p1, p2]
	end
end

count = {}
points = []
lines.each do |p1, p2|
	compute(p1,p2).each do |point|
		count[point.to_key] = 0 unless count.has_key?(point.to_key)
		count[point.to_key] += 1
		points << point
	end
end

0.upto(10).each do |y|
	0.upto(10).each do |x|
		pnew = Point.new(x,y)
		if points.include?(pnew)
			print count[pnew.to_key].inspect
		else
			print '.'
		end
	end
	puts ''
end

#puts count.inspect

puts count.select { |k,v| v > 1 }.count
