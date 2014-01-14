
require 'rspec'
require './sorted_array.rb'

describe SortedArray do

  describe 'initialize' do
    it 'can be instantiated' do
      sorted_array = SortedArray.new
      sorted_array.class.should == SortedArray
    end
    it 'can be given an array' do
      source = [4,7,3,9,2]
      sorted_array = SortedArray.new(source)
      sorted_array.size.should == source.size
    end
    it 'is sorted if initialized with an array' do
      source = [4,7,3,9,2]
      sorted_array = SortedArray.new(source)
      sorted_array[0...5].should == source.sort
    end
  end

  describe '#[]' do
    before do
      @source = [2,3,4,7,9]
      @sorted_array = SortedArray.new
      @sorted_array.internal_arr = @source
    end

    it 'indexes an element' do
      @sorted_array[2].should == 4
    end

    it 'gives nil for an out of range element' do
      @sorted_array[10].should == nil
    end

    it 'indexes a range' do
      @sorted_array[1..3].should == @source[1..3]
    end
  end

  describe '#size' do
    it 'gives the size of []' do
      sorted_array = SortedArray.new
      sorted_array.size.should == 0
    end
    it 'works with a starter array' do
      source = [4,7,3,9,2]
      sorted_array = SortedArray.new(source)
      sorted_array.size.should == source.size
    end
  end
  describe '#add' do
    before do
      @source = [4,7,3,9,2]
      @sorted_array = SortedArray.new(@source)
    end
    it 'can add an element' do
      @sorted_array.add(4)
      @sorted_array.size.should == @source.size + 1
    end
    it 'adds in the correct location' do
      @sorted_array.add(1)
      @sorted_array.add(10)
      @sorted_array[-1].should == 10
      @sorted_array[0].should == 1
    end
  end

  describe '#first_larger_index' do
    before do
      @source = [2,3,4,7,9]
      @sorted_array = SortedArray.new
      @sorted_array.internal_arr = @source
    end

    it 'gives 0 for an empty array' do
      @sorted_array.internal_arr = []
      @sorted_array.first_larger_index(4).should == 0
    end

    it 'can pick before or after a single element' do
      @sorted_array.internal_arr = [5]
      @sorted_array.first_larger_index(4).should == 0
      @sorted_array.first_larger_index(6).should == 1
    end

    it 'can pick before, after or between two elements' do
      @sorted_array.internal_arr = [5,6]
      @sorted_array.first_larger_index(4).should == 0
      @sorted_array.first_larger_index(6).should == 1
      @sorted_array.first_larger_index(8).should == 2
    end

    it 'can put an existing element on either side' do
      @sorted_array.internal_arr = [5]
      [0,1].include?(@sorted_array.first_larger_index(5)).should == true
    end

    it 'gives 0 for a new smallest' do
      @sorted_array.first_larger_index(-4).should == 0
    end

    it 'gives the last index for a new largest' do
      @sorted_array.first_larger_index(10).should == @sorted_array.size
    end
    it 'gives the right location' do
      @sorted_array.first_larger_index(5).should == 3
    end
  end

  describe '#index' do
    before do
      @source = ["Crisis","Balderdash","Masticate","Xanadu","Lemur"]
      # ["Balderdash", "Crisis", "Lemur", "Masticate", "Xanadu"]
      @sorted_array = SortedArray.new(@source)
    end
    it 'finds the middle item' do
      @sorted_array.index("Lemur").should == 2
    end
    it 'finds an item in the left half' do
      @sorted_array.index("Crisis").should == 1
    end
    it 'finds the last item' do
      @sorted_array.index("Xanadu").should == 4
    end
    it 'returns nil for an item not in the array' do
      @sorted_array.index("Boredom").should == nil
    end

    it 'returns nil for an item not in the array' do
      @sorted_array.index("Aaron").should == nil
    end
    it 'returns nil for an item greater than anything in the array' do
      @sorted_array.index("Zebra").should == nil
    end
  end
end
