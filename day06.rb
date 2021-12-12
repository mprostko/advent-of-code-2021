pool = File.read('day06.input').split(",").map(&:to_i)

def breed(pool, days)
  days.times.with_index do |day|
    pool.each_with_index do |fish, index|
      case fish
      when 0
        pool.append(9)
        pool[index] = 6
      else
        pool[index] -= 1
      end  
    end
  end

  pool.count
end

# require 'benchmark'

# time = Benchmark.measure do
#   puts breed(pool.dup, 120)
# end
# puts time.real

# puts '------'

# def megaBreed(fish_day, days_left)
#   return 1 if(days_left == 0)

#   children = 1
#   days_left.times do |day|
#     #puts "day #{day}, fish_day: #{fish_day}"
#     if (fish_day == 0)
#       #puts "SPAWN!"
#       breed = megaBreed(9, days_left - day)
#       fish_day = 6
#       #puts "Spawned = #{breed}"
#       children += breed
#     else
#       fish_day -= 1
#     end
#   end

#   return children
# end

# time = Benchmark.measure do
#   x = pool.map do |fish_day|
#     megaBreed(fish_day, 120)
#   end
#   puts "SUMA: #{x.sum}"
# end
# puts time.real

require 'pry'

@cache = []
def gigaBreed(days_to_live, current_day, max_day)
  children = ((max_day - current_day - days_to_live) / 6.0).ceil
  children = 0 if children < 0

  #puts "Days to live: #{days_to_live}, day: #{current_day.to_s.rjust(2, ' ')}, children: #{children}, level: #{level}, grand_dad: #{grand_dad}"

  grandchildren = 0
  children.times.map do |index|
    breed_day = days_to_live + current_day + 7 * index
    unless breed_day + 1 > max_day
      gc = @cache[breed_day+8+1] || @cache[breed_day+8+1] = gigaBreed(8, breed_day + 1, max_day)
      grandchildren += gc
    end
  end

  return 1 + grandchildren
end

puts (pool.map.with_index do |days_to_live, index|
  gigaBreed(days_to_live, 0, 256)
end).sum
