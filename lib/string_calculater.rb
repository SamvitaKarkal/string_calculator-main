class StringCalculator
  def add_string(input)
    return 'only accepts a string' unless input.is_a?(String)
    return 'invalid input' if  input =~ /,\n/
    negatives = ready_to_add_numbers(input).select { |num| num < 0 }
    raise "negative numbers not allowed #{negatives}" unless negatives.empty?
    return ready_to_add_numbers(input).sum
  end

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

  def ready_to_add_numbers(input)
    if input =~ /\n/ && !input.start_with?("//")
      input_array = input.split(/[\n,]/)
    elsif input.start_with?("//")
      delimiter_end_index = input.index("\n")
      delimiter = input[2...delimiter_end_index]
      input = input[(delimiter_end_index + 1)..]
      delimiter = Regexp.escape(delimiter)
      input_array = input.split(/#{delimiter}/) 
    else
      input_array = input.split(",")
    end
    input_array.map(&:to_i)
  end
end
