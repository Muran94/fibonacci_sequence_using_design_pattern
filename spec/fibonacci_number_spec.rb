# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FibonacciNumber do
  describe '.new' do
    context '引数に正常値が渡された場合' do
      it '正常にインタンスが生成され、返ってくること。' do
        expect(FibonacciNumber.new(0)).to be_an_instance_of FibonacciNumber
        expect(FibonacciNumber.new(1)).to be_an_instance_of FibonacciNumber
      end

      it '生成されたインスタンスがfreezeされていること。' do
        expect(FibonacciNumber.new(0)).to be_frozen
      end
    end

    context '引数に異常値が渡された場合' do
      it 'ArgumentErrorがraiseされること。' do
        expect { FibonacciNumber.new(nil) }.to raise_error ArgumentError, 'Argument `value` is required.'
        expect { FibonacciNumber.new('1') }.to raise_error ArgumentError, 'Argument `value` must be an instance of Integer class.'
        expect { FibonacciNumber.new(-1)  }.to raise_error ArgumentError, 'Argument `value` must be greater or equal to 0.'
      end
    end
  end

  describe '#to_i' do
    it '@valueの値を返すこと。' do
      expect(FibonacciNumber.new(0).to_i).to eq 0
      expect(FibonacciNumber.new(1).to_i).to eq 1
      expect(FibonacciNumber.new(2).to_i).to eq 2
      expect(FibonacciNumber.new(3).to_i).to eq 3
      expect(FibonacciNumber.new(5).to_i).to eq 5
    end
  end

  describe '#==' do
    it 'もう一つのFibonacciNumberのvalueと値が同じであればtrue、そうでなければfalseを返す。' do
      expect(FibonacciNumber.new(0) == FibonacciNumber.new(0)).to be_truthy
      expect(FibonacciNumber.new(0) == FibonacciNumber.new(1)).not_to eq be_falsy
    end
  end
end
