module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for i in self
      yield i
    end
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?
    i = 0
    my_each do |item|
      yield item, i
      i += 1
    end
  end

  def my_select
    return to_enum :my_select unless block_given?
    arry = []
    for i in self
      arry << i if yield i
    end
    arry
  end

  def my_all?(arg = nil)
    output = false
    filtered_array = if !arg # no arguments
                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true if filtered_array == to_a
    output
  end

  def my_any?(arg = nil)
    output = false
    filtered_array = if !arg # no arguments
                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true unless filtered_array.to_a.empty?
    output
  end

  def my_none?(arg = nil)
    output = false
    filtered_array = if !arg
                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true if filtered_array.to_a.empty?
    output
  end

  def my_count(argument = nil)
    if argument
      selected = my_select { |el| el == argument }
      selected.length
    else
      return to_a.length unless block_given?

      count = 0

      my_each do |el|
        yield(el) && count += 1
      end
      count
    end
  end

  def my_map(proc_block = nil)
    return to_enum(:my_map) unless block_given?

    new_arr = []

    if proc_block.class == Proc and block_given?
      my_each { |el| new_arr.push(proc_block.call(el)) }
    else
      my_each { |el| new_arr.push(yield(el)) }
    end

    new_arr
  end

  def my_inject(num = nil, symbol = nil)
    if block_given?
      sum = num
      my_each { |item| sum = sum.nil? ? item : yield(sum, item) }
      sum
    elsif !num.nil? && (num.is_a?(Symbol) || num.is_a?(String))
      sum = nil
      my_each { |item| sum = sum.nil? ? item : sum.send(num, item) }
      sum
    elsif !symbol.nil? && (symbol.is_a?(Symbol) || symbol.is_a?(String))
      sum = num
      my_each { |item| sum = sum.nil? ? item : sum.send(symbol, item) }
      sum
    else
      raise LocalJumpError unless block_given?
    end
  end

  def multiply_els(arr)
    arr.my_inject { |n, total| n * total }
  end
end
