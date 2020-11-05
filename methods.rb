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

end
