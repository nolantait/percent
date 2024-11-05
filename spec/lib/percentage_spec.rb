require "spec_helper"

describe Percentage do
  subject { described_class.new value }

  let(:value) { 0 }

  describe "methods" do
    it { is_expected.to respond_to(:value) }
    it { is_expected.to respond_to(:to_i) }
    it { is_expected.to respond_to(:to_c) }
    it { is_expected.to respond_to(:to_d) }
    it { is_expected.to respond_to(:to_f) }
    it { is_expected.to respond_to(:to_r) }
    it { is_expected.to respond_to(:to_complex) }
    it { is_expected.to respond_to(:to_decimal) }
    it { is_expected.to respond_to(:to_float) }
    it { is_expected.to respond_to(:to_rational) }
    it { is_expected.to respond_to(:to_s) }
    it { is_expected.to respond_to(:to_str) }
    it { is_expected.to respond_to(:to_string) }
    it { is_expected.to respond_to(:format) }
    it { is_expected.to respond_to(:to_amount) }
    it { is_expected.to respond_to(:inspect) }
    it { is_expected.to respond_to(:==) }
    it { is_expected.to respond_to(:eql?) }
    it { is_expected.to respond_to(:<=>) }
    it { is_expected.to respond_to(:+) }
    it { is_expected.to respond_to(:-) }
    it { is_expected.to respond_to(:/) }
    it { is_expected.to respond_to(:*) }
  end

  describe "class methods" do
    subject { described_class }

    it { is_expected.to respond_to(:from_fraction) }
    it { is_expected.to respond_to(:from_amount) }
  end

  context "Initialization methods" do
    shared_examples "a percentage" do |amount|
      let(:decimal_value) { amount.to_d / 100 }
      let(:string_value)  { "#{amount.to_f}%" }

      it "equals the given percentage" do
        expect(subject.value).to eql decimal_value
        expect(subject.format).to eql string_value
      end
    end

    describe "#initialize" do
      context "with value of 50" do
        let(:value) { 50 }

        it_behaves_like "a percentage", 50
      end

      context "with value of 0.5" do
        let(:value) { 0.5 }

        it_behaves_like "a percentage", 50
      end

      context "with a numeric value of 1/2" do
        let(:value) { Rational 1, 2 }

        it_behaves_like "a percentage", 50
      end

      context "with a numeric value of 0.5E0" do
        let(:value) { BigDecimal "0.5" }

        it_behaves_like "a percentage", 50
      end

      context "with a numeric value of 0.5+0i" do
        let(:value) { Complex(0.5, 0) }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "50"' do
        let(:value) { "50" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "50%"' do
        let(:value) { "50%" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "50.0%"' do
        let(:value) { "50.0%" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of ".5"' do
        let(:value) { ".5" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "0.5"' do
        let(:value) { "0.5" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "0.5E0"' do
        let(:value) { "0.5E0" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "1/2"' do
        let(:value) { "1/2" }

        it_behaves_like "a percentage", 50
      end

      context "with a boolean value of true" do
        let(:value) { true }

        it_behaves_like "a percentage", 100
      end

      context "with a boolean value of false" do
        let(:value) { false }

        it_behaves_like "a percentage", 0
      end
    end

    describe "#self.from_fraction" do
      let(:subject) { described_class.from_fraction value }

      context "with a numeric value of 50.0" do
        let(:value) { 50.0 }

        it_behaves_like "a percentage", 5000
      end

      context "with a numeric value of 50" do
        let(:value) { 50 }

        it_behaves_like "a percentage", 5000
      end

      context "with a numeric value of 1" do
        let(:value) { 1 }

        it_behaves_like "a percentage", 100
      end

      context "with a numeric value of 0" do
        let(:value) { 0 }

        it_behaves_like "a percentage", 0
      end

      context 'with a string value of "50.0"' do
        let(:value) { "50.0" }

        it_behaves_like "a percentage", 5000
      end

      context 'with a string value of "50"' do
        let(:value) { "50" }

        it_behaves_like "a percentage", 5000
      end

      context 'with a string value of "1"' do
        let(:value) { "1" }

        it_behaves_like "a percentage", 100
      end

      context 'with a string value of "0"' do
        let(:value) { "0" }

        it_behaves_like "a percentage", 0
      end
    end

    describe "#self.from_amount" do
      let(:subject) { described_class.from_amount value }

      context "with a numeric value of 50" do
        let(:value) { 50 }

        it_behaves_like "a percentage", 50
      end

      context "with a numeric value of 50.0" do
        let(:value) { 50.0 }

        it_behaves_like "a percentage", 50
      end

      context "with a numeric value of 0.5E2" do
        let(:value) { BigDecimal 50 }

        it_behaves_like "a percentage", 50
      end

      context "with a numeric value of 100/2" do
        let(:value) { Rational 100, 2 }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "50"' do
        let(:value) { "50" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "50.0"' do
        let(:value) { "50.0" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "0.5E2"' do
        let(:value) { "0.5E2" }

        it_behaves_like "a percentage", 50
      end

      context 'with a string value of "200/4"' do
        let(:value) { "200/4" }

        it_behaves_like "a percentage", 50
      end
    end
  end

  context "Attributes" do
    describe "#value" do
      context "when a value is passed to an initialization method" do
        let(:value) { BigDecimal("1.5") }

        it "returns that value" do
          expect(subject.value).to eql value
          expect(described_class.from_fraction(value).value).to eql value
          expect(described_class.from_amount(value * 100).value).to eql value
        end
      end

      context "when nothing is passed to an initialization method" do
        it "returns 0" do
          expect(described_class.new.value).to eql BigDecimal(0)
          expect(described_class.from_fraction.value).to eql BigDecimal(0)
          expect(described_class.from_amount.value).to eql BigDecimal(0)
        end
      end
    end
  end

  context "Conversions" do
    let(:value) { 75 }

    describe "#to_i" do
      context "with a numeric value of 75" do
        it "returns 75" do
          expect(subject.to_i).to be 75
        end
      end
    end

    describe "#to_c" do
      context "with a numeric value of 75" do
        it "returns 0.75E0+0i" do
          expect(subject.to_c).to eql Complex(BigDecimal("0.75"), 0)
        end
      end
    end

    describe "#to_d" do
      context "with a numeric value of 75" do
        it "returns 0.75E0" do
          expect(subject.to_d).to eql BigDecimal("0.75")
        end
      end
    end

    describe "#to_f" do
      context "with a numeric value of 75" do
        it "returns 0.75" do
          expect(subject.to_f).to be 0.75
        end
      end
    end

    describe "#to_r" do
      context "with a numeric value of 75" do
        it "returns 3/4" do
          expect(subject.to_r).to eql Rational(3, 4)
        end
      end
    end

    describe "#to_complex" do
      context "with a numeric value of 75" do
        it "returns 0.75E2+0i" do
          expect(subject.to_complex).to eql Complex(BigDecimal(75), 0)
        end
      end
    end

    describe "#to_decimal" do
      context "with a numeric value of 75" do
        it "returns 0.75E2" do
          expect(subject.to_decimal).to eql BigDecimal(75)
        end
      end
    end

    describe "#to_float" do
      context "with a numeric value of 75" do
        it "returns 75.0" do
          expect(subject.to_float).to be 75.0
        end
      end
    end

    describe "#to_rational" do
      context "with a numeric value of 75" do
        it "returns 75/1" do
          expect(subject.to_rational).to eql Rational(75, 1)
        end
      end
    end

    describe "#to_s" do
      context "with a numeric value of 75" do
        it 'returns "75"' do
          expect(subject.to_s).to eql "75"
        end
      end

      context "with a numeric value of 0.75" do
        let(:value) { 0.75 }

        it 'returns "75"' do
          expect(subject.to_s).to eql "75"
        end
      end

      context "with a numeric value of 0.755" do
        let(:value) { 0.755 }

        it 'returns "75.5"' do
          expect(subject.to_s).to eql "75.5"
        end
      end
    end

    describe "#to_str" do
      context "with a numeric value of 75" do
        it 'returns "0.75"' do
          expect(subject.to_str).to eql "0.75"
        end
      end
    end

    describe "#to_string" do
      context "with a numeric value of 75" do
        it 'returns "75%"' do
          expect(subject.to_string).to eql "75%"
        end
      end

      context "with a numeric value of 0.75" do
        let(:value) { 0.75 }

        it 'returns "75%"' do
          expect(subject.to_string).to eql "75%"
        end
      end

      context "with a numeric value of 0.755" do
        let(:value) { 0.755 }

        it 'returns "75.5%"' do
          expect(subject.to_string).to eql "75.5%"
        end
      end
    end

    describe "#format" do
      context "with a value of 0.6666" do
        let(:value) { 0.6666 }

        context "when passed no options" do
          it 'returns "66.66%"' do
            expect(subject.format).to eql "66.66%"
          end
        end

        context "when passed percent_sign: true" do
          it 'returns "66.66%"' do
            expect(subject.format(percent_sign: true)).to eql "66.66%"
          end
        end

        context "when passed percent_sign: false" do
          it 'returns "66.66"' do
            expect(subject.format(percent_sign: false)).to eql "66.66"
          end
        end

        context "when passed as_decimal: true" do
          it 'returns "0.6666"' do
            expect(subject.format(as_decimal: true)).to eql "0.6666"
          end
        end

        context "when passed rounded: true" do
          it 'returns "67%"' do
            expect(subject.format(rounded: true)).to eql "67%"
          end
        end

        context "when passed no_decimal: true" do
          it 'returns "66%"' do
            expect(subject.format(no_decimal: true)).to eql "66%"
          end
        end

        context "when passed no_decimal_if_whole: true" do
          it 'returns "66.66%"' do
            expect(subject.format(no_decimal_if_whole: true)).to eql "66.66%"
          end
        end

        context "when passed space_before_sign: true" do
          it 'returns "66.66 %"' do
            expect(subject.format(space_before_sign: true)).to eql "66.66 %"
          end
        end

        context "when passed percent_sign: false, rounded: true, space_before_sign: true" do
          it 'returns "67 "' do
            f = subject.format percent_sign: false, rounded: true, space_before_sign: true
            expect(f).to eql "67 "
          end
        end

        context "when passed no_decimal: true, space_before_sign: true" do
          it 'returns "66 %"' do
            f = subject.format no_decimal: true, space_before_sign: true
            expect(f).to eql "66 %"
          end
        end

        context "when passed percent_sign: false, as_decimal: true, no_decimal: true" do
          it 'returns "0.6666"' do
            f = subject.format percent_sign: false, as_decimal: true, no_decimal: true
            expect(f).to eql "0.6666"
          end
        end

        context "when passed no_decimal_if_whole: true, no_decimal: true, rounded: true" do
          it 'returns "67%"' do
            f = subject.format no_decimal_if_whole: true, no_decimal: true, rounded: true
            expect(f).to eql "67%"
          end
        end

        context "when passed no_decimal_if_whole: true, no_decimal: true" do
          it 'returns "66%"' do
            f = subject.format no_decimal_if_whole: true, no_decimal: true
            expect(f).to eql "66%"
          end
        end
      end
    end

    describe "#to_amount" do
      context "with a numeric value of 75" do
        it "returns 75" do
          expect(subject.to_amount).to be 75
        end
      end

      context "with a numeric value of 0.75" do
        let(:value) { 0.75 }

        it "returns 75" do
          expect(subject.to_amount).to be 75
        end
      end

      context "with a numeric value of 0.755" do
        let(:value) { 0.755 }

        it "returns 75.5" do
          expect(subject.to_amount).to be 75.5
        end
      end
    end
  end

  context "Comparisons" do
    let(:value) { 100 }
    let(:duplicate) { described_class.new value }
    let(:other) { described_class.new 99 }

    shared_examples_for "full ==" do
      it "equals a number with the same value" do
        expect(equivalent == subject).to be true
        expect(equivalent >= subject).to be true
        expect(equivalent <= subject).to be true
        expect(equivalent != subject).to be false
        expect(equivalent >  subject).to be false
        expect(equivalent <  subject).to be false

        expect(subject == equivalent).to be true
        expect(subject >= equivalent).to be true
        expect(subject <= equivalent).to be true
        expect(subject != equivalent).to be false
        expect(subject >  equivalent).to be false
        expect(subject <  equivalent).to be false
      end

      it "does not equal a number with a different value" do
        expect(subject == different).to be false
        expect(subject != different).to be true

        expect(different == subject).to be false
        expect(different != subject).to be true
      end
    end

    shared_examples_for "comparisons" do
      it "knows when something is greater than" do
        expect(subject > smaller).to be true
        expect(subject > larger).to be false
        expect(smaller > subject).to be false
        expect(larger  > subject).to be true
      end

      it "knows when something is less than" do
        expect(subject < smaller).to be false
        expect(subject < larger).to be true
        expect(smaller < subject).to be true
        expect(larger  < subject).to be false
      end

      it "knows when something is greater than or equal to" do
        expect(subject >= smaller).to be true
        expect(subject >= larger).to be false
        expect(smaller >= subject).to be false
        expect(larger  >= subject).to be true
      end

      it "knows when something is less than or equal to" do
        expect(subject <= smaller).to be false
        expect(subject <= larger).to be true
        expect(smaller <= subject).to be true
        expect(larger  <= subject).to be false
      end
    end

    describe "#==" do
      context "comparing with percentage" do
        it "equals itself" do
          expect(subject == subject).to be true
        end

        it "equals a different percentage object with the same value" do
          expect(subject == duplicate).to be true
        end

        it "does not equal a different percentage" do
          expect(subject == other).to be false
        end
      end

      context "comparing with integer" do
        let(:equivalent) { 1 }
        let(:different)  { 2 }

        it_behaves_like "full =="
      end

      context "comparing with complex" do
        let(:equivalent) { Complex(1.0, 0) }
        let(:different)  { Complex(1.00101, 0) }

        it "equals a number with the same value" do
          expect(equivalent == subject).to be true
          expect(equivalent != subject).to be false

          expect(subject == equivalent).to be true
          expect(subject != equivalent).to be false
        end

        it "does not equal a number with a different value" do
          expect(subject == different).to be false
          expect(subject != different).to be true

          expect(different == subject).to be false
          expect(different != subject).to be true
        end
      end

      context "comparing with decimal" do
        let(:equivalent) { BigDecimal(1) }
        let(:different)  { BigDecimal(".99") }

        it_behaves_like "full =="
      end

      context "comparing with float" do
        let(:equivalent) { 1.0 }
        let(:different)  { 1.1010 }

        it_behaves_like "full =="
      end

      context "comparing with rational" do
        let(:equivalent) { Rational(1) }
        let(:different)  { Rational(9, 8) }

        it_behaves_like "full =="
      end
    end

    describe "#eql?" do
      it "equals itself" do
        expect(subject.eql?(subject)).to be true
      end

      it "equals a different percentage object with the same value" do
        expect(subject.eql?(duplicate)).to be true
      end

      it "does not equal a different percentage" do
        expect(subject.eql?(other)).to be false
      end

      it "does not equal any other numbers with the same value" do
        expect(subject.eql?(1)).to be false
        expect(subject.eql?(1.0)).to be false
        expect(subject.eql?(Complex(1, 0))).to be false
        expect(subject.eql?(Rational(1))).to be false
        expect(subject.eql?(BigDecimal(1))).to be false
      end
    end

    describe "comparable" do
      it "is comparable" do
        expect(subject.is_a?(Comparable)).to be true
      end

      context "compared to other percentages" do
        let(:smaller) { other }
        let(:larger)  { described_class.new 101 }

        it_behaves_like "comparisons"
      end

      context "compared to decimals" do
        let(:smaller) { BigDecimal "0.999999" }
        let(:larger)  { BigDecimal "1.000001" }

        it_behaves_like "comparisons"
      end

      context "compared to floats" do
        let(:smaller) { 0.999999 }
        let(:larger)  { 1.000001 }

        it_behaves_like "comparisons"
      end

      context "compared to integers" do
        let(:smaller) { 0 }
        let(:larger)  { 2 }

        it_behaves_like "comparisons"
      end

      context "compared to rationals" do # rubocop:disable RSpec/MultipleMemoizedHelpers
        let(:denominator) { 10**10 }
        let(:smaller) { Rational denominator - 1, denominator }
        let(:larger)  { Rational denominator + 1, denominator }

        it_behaves_like "comparisons"
      end
    end
  end

  context "Mathematical operations" do
    let(:value)  { 25 }
    let(:number) { 10 }

    describe "#+" do
      context "when adding two percentages" do
        it "returns the sum of the two percentages" do
          expect(subject + subject).to eql described_class.new(50)
        end
      end

      context "when adding a percent and a number" do
        it "returns sum of the two" do
          expect(subject + number).to eq 10.25
          expect(number + subject).to eq 10.25
        end
      end
    end

    describe "#-" do
      context "when subtracting two percentages" do
        it "returns the difference of the two percentages" do
          expect(subject - subject).to eql described_class.new(0)
        end
      end

      context "when subtracting a percent and a number" do
        it "returns the difference between the two" do
          expect(subject - number).to eq(-9.75)
          expect(number - subject).to eq 9.75
        end
      end
    end

    describe "#*" do
      context "when multiplying two percentagess" do
        it "returns the product of the two percentages" do
          expect(subject * subject).to eql described_class.from_amount(6.25)
        end
      end

      context "when multiplying a percent and a number" do
        it "returns the product of the two" do
          expect(subject * number).to eq 2.5
          expect(number * subject).to eq 2.5
        end
      end
    end

    describe "#/" do
      context "when dividing two percentages" do
        it "returns the quotient of the two percentages" do
          expect(subject / subject).to eql described_class.new(100)
        end
      end

      context "when subtracting a percent and a number" do
        it "returns the quotient" do
          expect(subject / number).to eq 0.025
          expect(number / subject).to eq 40.0
        end
      end
    end
  end
end
