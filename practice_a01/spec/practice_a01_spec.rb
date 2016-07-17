require 'rspec'
require 'practice_a01'

describe "#my_each" do
  it "calls the block passed to it" do
    expect do |block|
      ["test array"].my_each(&block)
    end.to yield_control.once
  end

  it "yields each element to the block" do
    expect do |block|
      ["el1", "el2"].my_each(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it "does NOT call the built-in #each method" do
    original_array = ["original array"]
    expect(original_array).not_to receive(:each)
    original_array.my_each {}
  end

  it "is chainable and returns the original array" do
    original_array = ["original array"]
    expect(original_array.my_each {}).to eq(original_array)
  end
end

describe "#my_map" do
  it "calls the block passed to it" do
    expect do |block|
      ["test array"].my_map(&block)
    end.to yield_control.once
  end

  it "yields each element to the block" do
    expect do |block|
      ["el1", "el2"].my_map(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it "runs the block for each element" do
    expect([1, 2, 3].my_map { |el| el * el }).to eq([1, 4, 9])
    expect([-1, 0, 1].my_map { |el| el.odd? }).to eq([true, false, true])
  end

  it "does NOT call the built in built-in #map method" do
    original_array = ["original array"]
    expect(original_array).not_to receive(:map)
    original_array.my_map {}
  end

  it "is chainable and returns a new array" do
    original_array = ["original array"]
    expect(original_array.my_map {}).not_to eq(original_array)
  end
end

describe "#my_select" do
  it "calls the block passed to it" do
    expect do |block|
      ["test element"].my_select(&block)
    end.to yield_control
  end

  it "yields each element to the block" do
    test_array = ["el1", "el2", "el3"]
    expect do |block|
      test_array.my_select(&block)
    end.to yield_successive_args("el1", "el2", "el3")
  end

  it "returns an array of filtered down items" do
    test_array = [1, 2, 3, 4, 5]
    expect(test_array.my_select(&:odd?)).to eq([1, 3, 5])
    expect(test_array.my_select { |el| el < 3 }).to eq([1, 2])
  end

  it "does NOT call the built-in #select method" do
    test_array = ["el1", "el2", "el3"]
    expect(test_array).not_to receive(:select)
    test_array.my_select {}
  end
end

describe "#bubble_sort!" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].bubble_sort!).to eq([])
  end

  it "works with an array of one item" do
    expect([1].bubble_sort!).to eq([1])
  end

  it "sorts numbers" do
    expect(array.bubble_sort!).to eq(array.sort)
  end

  it "modifies the original array" do
    duped_array = array.dup
    array.bubble_sort!
    expect(duped_array).not_to eq(array)
  end

  it "will use a block if given" do
    sorted = array.bubble_sort! do |num1, num2|
      # order numbers based on descending sort of their squares
      num2**2 <=> num1**2
    end

    expect(sorted).to eq([5, 4, 3, 2, 1])
  end
end

describe "#bubble_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "delegates to #bubble_sort!" do
    expect_any_instance_of(Array).to receive(:bubble_sort!)

    array.bubble_sort
  end

  it "does not modify the original array" do
    duped_array = array.dup
    array.bubble_sort
    expect(duped_array).to eq(array)
  end
end
