require 'spec_helper'

RSpec.describe FibonacciSequenceLength do
  describe '.new' do
    context '引数に正常値が渡された場合' do
      it '正常にインスタンスが生成され、返ってくること。' do
        expect(FibonacciSequenceLength.new(2)).to be_an_instance_of FibonacciSequenceLength
        expect(FibonacciSequenceLength.new(3)).to be_an_instance_of FibonacciSequenceLength
        expect(FibonacciSequenceLength.new(4)).to be_an_instance_of FibonacciSequenceLength
      end

      it '生成されたインスタンスがfreezeされていること。' do
        expect(FibonacciSequenceLength.new(2)).to be_frozen
      end
    end

    context '引数に異常値が渡された場合' do
      it 'ArgumentErrorがraiseされること。' do
        expect { FibonacciSequenceLength.new(nil) }.to raise_error ArgumentError, 'Argument `value` is required.'
        expect { FibonacciSequenceLength.new('1') }.to raise_error ArgumentError, 'Argument `value` must be an instance of Integer class.'
        expect { FibonacciSequenceLength.new(1) }.to   raise_error ArgumentError, 'Argument `value` must be greater or equal to 2.'
      end
    end
  end

  describe '#to_i' do
    it '@valueの値をそのまま返すこと。' do
      expect(FibonacciSequenceLength.new(2).to_i).to eq 2
      expect(FibonacciSequenceLength.new(3).to_i).to eq 3
    end
  end
end
