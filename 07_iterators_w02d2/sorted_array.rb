class SortedArray
  attr_accessor :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each &block

    i = 0
    while i < @internal_arr.size
      yield @internal_arr[i]
      i += 1
    end
    @internal_arr

  end

  # int_arr = int_arr.map! { |x| 5 * x}

  def map &block

    return_arr = []
    self.each { |ele| return_arr.push(yield ele) }
    return_arr

  end

  def map! &block
    
    return_arr = []
    self.each { |ele| return_arr.push(yield ele) }
    @internal_arr = return_arr

  end

  def find &block
    return_ele = nil

    self.each do |ele| 
      if yield(ele)
        return_ele = ele
        break
      end
    end

    return_ele

  end
  
  def inject acc=nil, &block

    if acc.class == Symbol
      # if acc is a symbol, then that's the method we'll use to accumulate
      op = acc
      acc = @internal_arr.shift
      self.each { | ele | acc = acc.send(op, ele)}
      @internal_arr.unshift(acc)

    elsif acc == nil
      # if acc is nil, then set it to the first value in the arr
      acc = @internal_arr.shift
      self.each { |ele| acc = yield(acc, ele) }
      @internal_arr.unshift(acc)

    else
      # Acc is set to the first value of @internal_arr
      self.each { |ele| acc = yield(acc, ele) }
    end

    acc
    
  end
    
  # 
  

# hash = Hash.new
# %w(cat dog wombat).each_with_index { |item, index|
#   hash[item] = index
# }
# hash 

  def each_with_index &block

    i = 0
    self.each do | ele |
      yield(ele, i)
      i += 1
    end

  end

end