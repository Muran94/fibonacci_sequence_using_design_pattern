# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FibonacciSequence do
  describe '.new' do
    it '正常にインスタンスが生成され、返ってくること。' do
      expect(FibonacciSequence.send(:new)).to be_an_instance_of(FibonacciSequence)
    end

    it '生成されたインスタンスがfreezeされている（不変オブジェクトである）こと。' do
      expect(FibonacciSequence.send(:new)).to be_frozen
    end
  end

  describe '.generate(length: 2)' do
    context '引数に正常値が渡された場合' do
      it '指定の長さの要素を持つ@fibonacci_numbersをインスタンス変数に持つ、FibonacciSequenceクラスのインスタンスが返ってくること。' do
        fibonacci_sequence = FibonacciSequence.generate(length: 2)

        expect(fibonacci_sequence).to be_an_instance_of(FibonacciSequence)
        expect(fibonacci_sequence.to_a).to eq [0, 1]

        fibonacci_sequence = FibonacciSequence.generate(length: 10)

        expect(fibonacci_sequence).to be_an_instance_of(FibonacciSequence)
        expect(fibonacci_sequence.to_a).to eq [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
      end
    end

    context '引数に異常値が渡された場合' do
      it 'ArgumentErrorがraiseされること。' do
        expect { FibonacciSequence.generate(length: nil) }.to raise_error InvalidAttributeError, 'Attribute `value` is required.'
        expect { FibonacciSequence.generate(length: '1') }.to raise_error InvalidAttributeError, 'Attribute `value` must be an instance of Integer class.'
        expect { FibonacciSequence.generate(length: -10) }.to raise_error InvalidAttributeError, 'Attribute `value` must be greater or equal to 2.'
      end
    end
  end

  describe '#length' do
    it 'フィボナッチ数列を構成する要素の個数を数値で返すこと。' do
      expect(FibonacciSequence.generate.length).to eq 2
      expect(FibonacciSequence.generate(length: 4).length).to eq 4
      expect(FibonacciSequence.generate(length: 10).length).to eq 10
    end
  end

  describe '#to_a' do
    it 'フィボナッチ数列の要素を配列にして返す。' do
      expect(FibonacciSequence.generate(length: 2).to_a).to eq [0, 1]
      expect(FibonacciSequence.generate(length: 5).to_a).to eq [0, 1, 1, 2, 3]
    end
  end

  describe '#to_s' do
    it 'フィボナッチ数列を構成する数字を、「, 」区切りで連結して、文字列として返すこと。' do
      expect(FibonacciSequence.generate(length: 2).to_s).to eq '0, 1'
      expect(FibonacciSequence.generate(length: 5).to_s).to eq '0, 1, 1, 2, 3'
    end
  end
end
