class Bingo
 	attr_accessor :numbers, :board

 	def self.parse(data)
 		data = data.split("\n").map { |row| row.squeeze(' ').split(' ').map(&:to_i) }
 		Bingo.new(data)
 	end

 	def initialize(board)
 		@finished = false
 		@numbers = []
 		@board = board
 	end

 	def next(number)
 		return nil if finished?
 		nullify(number)
 		numbers << number
 		@finished = check
 	end

 	def print
 		board.each do |row|
 			puts row.map{ |num| num.to_s.rjust(2, ' ') }.join(' ')
 		end
 	end

 	def finished?
 		@finished
 	end

 	def score
 		board.map{ |row| row.compact.sum }.sum * numbers.last
 	end

 	private
 	def nullify(number)
 		board.each_with_index do |row, y|
 			row.each_with_index do |val, x|
 				board[y][x] = nil if val == number
 			end
 		end
 	end

 	def check
 		# rows
 		board.each do |row|
 			return true if check_row(row)
 		end
 		# cols
 		board.transpose.each do |row|
 			return true if check_row(row)
 		end
 		false
 	end

 	def check_row(row)
 		x = !row.select{ |x| x != nil }.any?
 	end
end

data = File.read('day04.input').split("\n\n")

boards = data[1..-1].map { |data| Bingo.parse(data) }

numbers = data[0].split(',').map(&:to_i)

first_score = nil
last_score = nil

numbers.each do |number|
	boards.each_with_index do |board,index|
		next if board.finished?
		board.next(number)

		if board.finished?
			first_score = board.score unless first_score			
			last_score = board.score
		end
	end
end

puts first_score.inspect
puts last_score.inspect
