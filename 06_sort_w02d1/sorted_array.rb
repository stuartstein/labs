class SortedArray
  attr_accessor :internal_arr # This is for convenience in the tests.

  def initialize(input_arr=[])
    
    @internal_arr = []

    # Pass each element in input_arr to 'add' method (if it isn't empty)
    input_arr.each { | ele | add(ele) } 

  end

  def add(new_ele)
    
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
        return first_larger_index(target, mid_ind + 1, end_ind)
      else
        return first_larger_index(target, start_ind, mid_ind)
      end

    end
  end

  def index(target)
    @internal_arr.include?(target) ? first_larger_index(target) : nil
  end

end