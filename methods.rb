module Enumerable
  def my_each
    for i in self
      yield i
    end
  end

  def my_each_with_index
    i = 0
    my_each do |item|
      yield item, i
      i += 1
    end
  end

  def my_select
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

  def my_count
    count = 0
    count += 1 if size > 1
    yield count
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

  def my_inject(init = nil)
    if init.nil?
      initialize_num = true
    elsif init.is_a?(Symbol)
      return my_inject { |sum, n| sum.method(init).call(n) }
    else
      sum = init
      initialize_num = false
    end
    for i in self
      if initialize_num
        sum = i
        initialize_num = false
      else
        sum = yield sum, i
      end
    end
    sum
  end

  def multiply_els(arr)
    arr.my_inject { |n, total| n * total }
  end
end
