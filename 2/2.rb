file = File.read("./2-input.txt")

reports = []

file.each_line do |line|
  report = line.split.map(&:to_i)
  reports.push report
end

def is_valid_report(report, allow_one_error=false)
  # check if report is sorted (ascending or descending)
  is_sorted = if report == report.sort
                true
              elsif report == report.sort.reverse
                true
              else
                false
              end

  # check if report is not too steep
  #
  # a report is considered steep, if adjancent numbers
  # have a delta larger than 3 or smaller than 1
  is_steep = false
  report.each_with_index do |n, index|
    if !report[index + 1]
      break
    end
    delta = (n - report[index + 1]).abs
    if delta < 1 || delta > 3
      is_steep = true
      break
    end
  end

  is_valid = is_sorted && !is_steep

  if !is_valid && allow_one_error
    # function should call itself with every permutation
    # of removing each element to allow for "one error"
    has_valid_permutation = false
    report.each_with_index do |n, index|
      report_without_n = report.dup
      report_without_n.delete_at index
      if is_valid_report report_without_n
        has_valid_permutation = true
        break
      end
    end
  end

  return is_valid || has_valid_permutation
end

# Part 1

n_of_valid_reports = 0

reports.each do |report|
  if is_valid_report report
    n_of_valid_reports += 1
  end
end

puts n_of_valid_reports

# Part 2

n_of_valid_reports_with_possible_error = 0

reports.each do |report|
  if is_valid_report(report, allow_one_error=true)
    n_of_valid_reports_with_possible_error += 1
  end
end

puts n_of_valid_reports_with_possible_error
