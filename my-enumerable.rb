# You learned about the Enumerable module that gets mixed in to the Array and Hash classes (among others) 
# and provides you with lots of handy iterator methods. To prove that there's no magic to it, you're going 
# to rebuild those methods.

module Enumerable
  def my_each #3
     i=0
     arr = self.to_a
     while i<arr.length
      yield(arr[i])
      i+=1
    end
  end

  def my_each_with_index #4
    i=0
    arr = self.to_a
    while i<arr.length
      yield(arr[i],i)
      i+=1
    end
  end

  def my_select #5
  new_array = []
  self.my_each do |i|
    if yield(i)
      new_array << i
    end
  end
  return new_array
  end

  def my_all? #6
  all = true
    self.my_each do |i|
      if yield(i)
        next
      else
        return false
      end
    end
  return all
  end

  def my_any? #7
  any = false
    self.my_each do |i|
      if yield(i)
        return true
      else
        next
      end
    end
  return any
  end

  def my_none? #8
  none = true
    self.my_each do |i|
      if yield(i)
        return false
      else
        next
      end
    end
  return none
  end

  def my_count(to_match=nil) #9
  any = 0
    self.my_each do |i|
      if block_given? 
        any += 1 unless !yield(i)
      elsif to_match != nil
        any += 1 if i == to_match
      else
        any += 1
      end
    end
  return any
  end

  def my_map #10
  new_array = []
    self.my_each do |i|
      result = yield(i)
      new_array << result
    end
  return new_array
  end

  def my_inject(arg=0) #11
    cur_arr = self.to_a
    cur_arr.my_each do |n|
      result = yield(arg,n)
      arg = result
    end
    return arg
  end
end

def multiply_els(arr) #12 
  arr.my_inject(1) {|result,element| result*element}
end

p [1, 2, 3, 4].inject { |result, element| result + element }
p [1, 2, 3, 4].my_inject(0) { |result, element| result + element }
