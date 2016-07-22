require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)!
 Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:brownie) { Dessert.new("brownie", 100) }

  describe "#initialize" do
    it "sets a type" do
      expect(brownie.type).to eq("brownie")
    end

    it "sets a quantity" do
      expect(brownie.quantity).to eq(100)
    end

    it "starts ingredients as an empty array" do
      expect(brownie.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "tons") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect do
        brownie.add_ingredient('eggs')
        (brownie.ingredients).to eq(['eggs'])
      end
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      expect do
        brownie.add_ingredient('eggs')
        brownie.add_ingredient('eggs')
        brownie.add_ingredient('milk')
        brownie.mix!
        (brownie.ingredients).to_not eq(['eggs', 'eggs', 'eggs', 'milk'])
      end
    end

  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      expect do
        brownie.eat
        (brownie.quantity).to eq (99)
      end
    end

    it "raises an error if the amount is greater than the quantity" do
      expect do
        100.times do
          brownie.eat
        end.to raise_error
      end
    end
  end
end
