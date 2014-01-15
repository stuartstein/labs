require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          # expect { sorted_array.map {|el| el } }.to_not change { original_array }
          expect { sorted_array.map {|el| 2 * el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new object' do
          sorted_array.map { |el| el }.should_not be sorted_array
        end

        it 'the new object should be an array' do
          sorted_array.map { |el| el }.class.should == Array
        end

        it 'new array contains values returned by the block'  do
          sorted_array.map { |el| 7 * el }.should eq source.map { |el| 7 * el }
        end
      end
    end

    describe "that update the original array" do
      describe :map! do

        it 'the original array should be updated' do
          sorted_array.map! {|el| 7 * el }.should_not eq(source)
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block'  do
          sorted_array.map! { |el| 7 * el }
          sorted_array.internal_arr.should eq(source.map { |ele| 7 * ele})
        end

      end
    end
  end

  describe :find do

    it "should return the first element where block is not false" do
      sorted_array.find { |i| i % 2 == 0 }.should eq(source.select{|i| i % 2 == 0}.shift)
    end

    it "should return nil if no match is detected" do
      sorted_array.find { |i| i % 10 == 0 }.should eq(nil)
    end

  end

  describe :inject do
    # specify do 
    #   expect do |b| 
    #     block_with_two_args = Proc.new { |acc, el| return true}
    #     sorted_array.send(method, acc, &b) 
    #   end.to yield_successive_args([2, acc],[3, acc],[4, acc], [7, acc], [9, acc]) 
    # end

    it 'should be able to return the sum of the numbers in the array' do
      sorted_array.inject { |sum, n| sum + n }.should eq(source.inject{ |sum, n| sum + n })
    end

    it 'should take a starting value for the accumulator' do
      sorted_array.inject(5) { |sum, n| sum + n }.should eq(source.inject(5){ |sum, n| sum + n })
    end

    it "should be able to return the product of the array" do
      sorted_array.inject { |sum, n| sum * n }.should eq(source.inject{ |product, n| product * n })
    end

    it 'should take symbol as a parameter' do
      sorted_array.inject(:+).should eq(source.inject(:+))
    end

 end

end
