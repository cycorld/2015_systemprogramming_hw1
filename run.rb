require 'csv'

RESOLUTION = 2
ITERATION = 30

result_ij = Hash.new
result_ji = Hash.new
temp = Array.new

1.upto (1024 / RESOLUTION - 1) do |s|
  size = s * RESOLUTION
  ITERATION.times do |try|
    result = %x[./ij.out #{size}].to_f
    STDOUT.write "\rIJ | (#{(size - 1) * ITERATION + try} / #{1023 * ITERATION}) RESULT : #{result}"
    temp << result
  end
  result_ij["#{4 * size * size}"] = temp.inject{|sum, x| sum + x}.to_f / temp.size
  temp = Array.new
end

1.upto (1024 / RESOLUTION - 1) do |s|
  size = s * RESOLUTION
  ITERATION.times do |try|
    result = %x[./ji.out #{size}].to_f
    STDOUT.write "\rJI | (#{(size - 1) * ITERATION + try} / #{1023 * ITERATION}) RESULT : #{result}"
    temp << result
  end
  result_ji["#{4 * size * size}"] = temp.inject{|sum, x| sum + x}.to_f / temp.size
  temp = Array.new
end

puts result_ij
puts result_ji
CSV.open("result_res#{RESOLUTION}_iter#{ITERATION}_#{Time.now.to_i}.csv", "w") do |csv|
  csv << ["type", "byte", "time"]
  result_ij.each do |k, v|
    csv << ["ij", k, v]
  end
  result_ji.each do |k, v|
    csv << ["ji", k, v]
  end
end
