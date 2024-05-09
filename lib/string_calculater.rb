class StringCalculator
  def add(*inputs)
    if inputs.count > 1
      sum_arr = []
      inputs.map{|str| str.split(",")}.each do |input|
        actual_input = input.join(",")
        sum_arr << add_string(actual_input)
      end
      return sum_arr
    else
      add_string(inputs.first)
    end
  end

  private

  def add_string(input)
    validate_input(input)

    numbers = parse_input(input)
    handle_negatives(numbers)

    numbers.sum
  end

  def validate_input(input)
    # return will not throw required error. Changed to raise
    raise 'only accepts a string' unless input.is_a?(String)
    raise 'invalid input' if  input =~ /,\n/
  end

  def handle_negatives(numbers)
    negatives = numbers.select { |num| num.negative? }
    raise "negative numbers not allowed #{negatives}" unless negatives.empty?
  end

  # broke down ready_to_add_numbers method into smaller methods
  def parse_input(input)
    delimiter = determine_delimiter(input)
    input = remove_delimiter_specifier(input)
  
    input.split(/#{delimiter}|\n/).map(&:to_i)
  end
  
  def determine_delimiter(input)
    return ',' unless input.start_with?("//")
  
    delimiter_end_index = input.index("\n")
    input[2...delimiter_end_index]
  end
  
  def remove_delimiter_specifier(input)
    return input unless input.start_with?("//")
  
    delimiter_end_index = input.index("\n")
    input[(delimiter_end_index + 1)..]
  end
end
