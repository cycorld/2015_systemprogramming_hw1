require 'csv'

result_ij = Hash.new
result_ji = Hash.new
temp = Array.new

1.upto 255 do |s|
  size = s * 4
  20.times do |try|
    result = %x[./ij #{size}].to_f
    STDOUT.write "\rIJ | (#{(size - 1) * 20 + try} / 20460) RESULT : #{result}"
    temp << result
  end
  result_ij["#{4 * size * size}"] = temp.inject{|sum, x| sum + x}.to_f / temp.size
  temp = Array.new
end

1.upto 255 do |s|
  size = s * 4
  20.times do |try|
    result = %x[./ji #{size}].to_f
    STDOUT.write "\rJI | (#{(size - 1) * 20 + try} / 20460) RESULT : #{result}"
    temp << result
  end
  result_ji["#{4 * size * size}"] = temp.inject{|sum, x| sum + x}.to_f / temp.size
  temp = Array.new
end

puts result_ij
puts result_ji
CSV.open("result.csv", "w") do |csv|
  csv << ["type", "byte", "time"]
  result_ij.each do |k, v|
    csv << ["ij", k, v]
  end
  result_ji.each do |k, v|
    csv << ["ji", k, v]
  end
end
