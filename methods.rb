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

# ***************************     my_all     *********************************


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


# ***************************     my_any     *********************************



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


# ***************************     my_none     ********************************



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
    if self.size > 1
      count += 1
    end
    yield count
  end
  

end