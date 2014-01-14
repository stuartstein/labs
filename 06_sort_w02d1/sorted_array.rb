class SortedArray
  attr_accessor :internal_arr # This is for convenience in the tests.

  def initialize(input_arr=[])
    @internal_arr = []
    # @input_arr = input_arr
    # unless input_arr.empty?
    #   input_arr.each { | ele | @internal_arr.add(ele) }
    # end

    # Fill in the rest of the initialize method here.
    # What should you do with each element of the incoming array?
  end

  def add(new_ele)
    # Hint: Use the Array#insert method.
    insert_ind = first_larger_index(new_ele)
    @internal_arr.insert(insert_ind, new_ele) 
  end

  def size
    @internal_arr.size
  end

  def [](index)
    @internal_arr[index]
  end

  def first_larger_index(target, start_ind=0, end_ind=@internal_arr.size)
    
    if start_ind >= end_ind
      return end_ind
    else
      mid_ind = (start_ind + end_ind) / 2
      if target > @internal_arr[ mid_ind ]
          first_larger_index(target, mid_ind + 1, end_ind)
      else
          first_larger_index(target, start_ind, mid_ind)
      end
    end
  end

  def index(target)
    @internal_arr.index(target)
  end

end
