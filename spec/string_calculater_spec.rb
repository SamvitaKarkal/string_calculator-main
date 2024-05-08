require './lib/string_calculater'

describe "StringCalculator" do
  describe "#add" do
    let(:calculator){ StringCalculator.new }  #generating instance locally, before generates for each spec for multiple describes
    
    it "returns 0 the sum of empty string" do
      expect(calculator.add("")).to eql(0)
    end

    it "returns the sum of two numbers" do
      expect(calculator.add("2,5")).to eql(7)
    end

    it "returns 'only accepts a string' when not string" do
      expect(calculator.add(2)).to eql('only accepts a string')
    end

    it "raise exception for negative numbers" do
      expect {calculator.add("1,-2,3") }.to raise_error("negative numbers not allowed [-2]")
    end

    it "does not raise an exception for non-negative numbers" do
      expect { calculator.add("1,2,3") }.not_to raise_error
    end

    it 'should return a number if the passed string contains no delimiters' do
      expect(calculator.add('123')).to eq (123)
    end

    it 'should return a number if the passed string contains no delimiters' do
      expect(calculator.add("123,1", "1,2")).to eq ([124, 3])
    end

    it 'should return a number if the passed string contains no delimiters' do
      expect(calculator.add("123,1", "1,2", "1,1")).to eq ([124, 3, 2])
    end

    it "adds each string separately" do
      expect(calculator.add("123\n1", "1\n2,3")).to eq([124, 6])
    end

    it "should return invalid input string separately" do
      expect(calculator.add("1,\n")).to eq('invalid input')
    end

    it "should allow delimeters" do
      expect(calculator.add("//;\n1;2")).to eq(3)
    end
  end
end
