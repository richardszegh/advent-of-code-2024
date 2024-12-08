file = File.read("./3-input.txt")

corrupt_instructions = ""

file.each_line do |line|
  corrupt_instructions << line
end

# Part 1

instructions = corrupt_instructions.scan(/mul\([0-9]*\,[0-9]*\)/)

sum = 0

instructions.each do |instruction|
  numbers = instruction.scan(/[0-9]*\,[0-9]*/)[0]
  n1 = Integer numbers.split(",")[0]
  n2 = Integer numbers.split(",")[1]
  sum += n1 * n2
end

puts sum

# Part 2

instructions_with_do_dont = corrupt_instructions.scan(/(mul\([0-9]*,[0-9]*\)|don't\(\)|do\(\))/)

sum_with_do_dont = 0
is_mul_enabled = true

instructions_with_do_dont.each do |instruction|
  instruction_string = instruction.kind_of?(Array) ? instruction[0] : instruction
  if /don't\(\)/.match(instruction_string)
    is_mul_enabled = false
  elsif /do\(\)/.match(instruction_string)
    is_mul_enabled = true
  else
    if is_mul_enabled
      numbers = instruction_string.scan(/[0-9]*\,[0-9]*/)[0]
      n1 = Integer numbers.split(",")[0]
      n2 = Integer numbers.split(",")[1]
      sum_with_do_dont += n1 * n2
    end
  end
end

puts sum_with_do_dont
