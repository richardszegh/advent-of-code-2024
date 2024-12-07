file = File.read("./1-input.txt")

column1 = []
column2 = []

file.each_line do |line|
  column1.push Integer line.split[0]
  column2.push Integer line.split[1]
end

column1 = column1.sort
column2 = column2.sort

# Part 1

distances = []

column1.each_with_index do |number, index|
  distance = number - column2[index]
  distances.push distance.abs
end

puts distances.sum

# Part 2

familiarity_scores = []

column1.each do |number|
  column2_appearances = column2.select { |n| n === number }
  familiarity = number * column2_appearances.length
  familiarity_scores.push familiarity
end

puts familiarity_scores.sum
