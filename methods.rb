module Enumerable
  # ############################################################################

  # ***************************     my_each     ********************************

  # ############################################################################

  def my_each
    return to_enum(:my_each) unless block_given?

    ind = 0

    while ind != to_a.length
      yield to_a[ind]
      ind += 1
    end

    self
  end

  # ############################################################################

  # ***********************     my_each_with_endex     *************************

  # ############################################################################

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?
    i = 0
    my_each do |item|
      yield item, i
      i += 1
    end

    self
  end

  # ############################################################################

  # ***************************     my_select     ******************************

  # ############################################################################

  def my_select
    return to_enum :my_select unless block_given?
    arry = []
    for i in self
      arry << i if yield i
    end

    filtered
  end

  # ############################################################################

  # ***************************     my_all     *********************************

  # ############################################################################

  def my_all?(arg = nil)
    output = false

    filtered_array = if !arg # no arguments

                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       # if argument is not empty then checking if arg is Class or object value
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true if filtered_array == to_a
    output
  end

  # ############################################################################

  # ***************************     my_any     *********************************

  # ############################################################################

  def my_any?(arg = nil)
    output = false

    filtered_array = if !arg # no arguments

                       block_given? ? my_select { |el| yield(el) } : my_select { |el| el }
                     elsif arg.is_a?(Regexp)
                       my_select { |el| arg.match(el) }
                     elsif arg.is_a?(Class)
                       # if argument is not empty then checking if arg is Class or object value
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true unless filtered_array.to_a.empty?
    output
  end

  # ############################################################################

  # ***************************     my_none     ********************************

  # ############################################################################

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

  # ############################################################################

  # ***************************     my_count     *******************************

  # ############################################################################

  def my_count(num = nil)
    if num
      selected = my_select { |el| el == num }
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

<<<<<<< HEAD
  # ############################################################################

  # ***************************     my_map     *********************************

  # ############################################################################

=======
>>>>>>> 6422db4d8d41e870337c18aa32ed4807b53d46e1
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

    output
  end
end

p Range.new(1, 4).my_inject(-10, :/)
p Range.new(1, 4).inject(-10, :/)
