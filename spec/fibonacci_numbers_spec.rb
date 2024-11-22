# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FibonacciNumbers do
  describe 'FIRST_TWO_NUMBERS' do
    it 'フィボナッチ数列における、最初の二つの数値を持つ配列が返ってくること。また、freezeされていること。' do
      # matchマッチャーを使用すると、オブジェクトIDが一致しているかかどうか検証し、テストに失敗してしまうため、数値に変換して比較する。
      expect(FibonacciNumbers::FIRST_TWO_NUMBERS.map(&:to_i)).to match [FibonacciNumber.new(0).to_i, FibonacciNumber.new(1).to_i]
      expect(FibonacciNumbers::FIRST_TWO_NUMBERS).to be_frozen
    end
  end

  describe '.new' do
    context '引数に正常値が渡された場合' do
      it '正常にインスタンスが生成され、返ってくること。' do
        expect(FibonacciNumbers.new).to be_an_instance_of(FibonacciNumbers)
      end

      it '生成されたインスタンスがfreezeされていること。' do
        expect(FibonacciNumbers.new).to be_frozen
      end
    end

    context '引数に異常値が渡された場合' do
      it 'ArgumentErrorがraiseされること。' do
        expect { FibonacciNumbers.new(nil)    }.to raise_error ArgumentError, 'Argument `collection` is required.'
        expect { FibonacciNumbers.new('0, 1') }.to raise_error ArgumentError, 'Argument `collection` must be an instance of Array Class, including FibonacciNumber Objects.'
        expect { FibonacciNumbers.new([])     }.to raise_error ArgumentError, 'Argument `collection` must contain 0 and 1 for the first two elements.'
      end
    end
  end

  describe '.generate' do
    context '引数に正常値が渡された場合' do
      it '指定の個数の要素を@collectionに持つ、FibonacciNumbersクラスのインスタンスが返ってくること。' do
        fibonacci_sequence = FibonacciNumbers.generate(length: 2)

        expect(fibonacci_sequence).to be_an_instance_of(FibonacciNumbers)
        expect(fibonacci_sequence.to_a).to eq [0, 1]

        fibonacci_sequence = FibonacciNumbers.generate(length: 10)

        expect(fibonacci_sequence).to be_an_instance_of(FibonacciNumbers)
        expect(fibonacci_sequence.to_a).to eq [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
      end
    end

    context '引数に異常値が渡された場合' do
      it 'ArgumentErrorがraiseされること。' do
        expect { FibonacciNumbers.generate(length: nil) }.to raise_error ArgumentError, 'Argument `length` is required.'
        expect { FibonacciNumbers.generate(length: '1') }.to raise_error ArgumentError, 'Argument `length` must be an instance of Integer class.'
        expect { FibonacciNumbers.generate(length: -10) }.to raise_error ArgumentError, 'Argument `length` must be greater or equal to 2.'
      end
    end
  end

  describe '#add' do
    it '新しいフィボナッチ数が追加された@collectionをデータに持つFibonacciNumbersのインスタンスが返ってくること。' do
      fibonacci_numbers = FibonacciNumbers.generate

      expect(fibonacci_numbers.to_a).to eq [0, 1]

      fibonacci_numbers = fibonacci_numbers.add

      expect(fibonacci_numbers).to be_an_instance_of(FibonacciNumbers)
      expect(fibonacci_numbers.to_a).to eq [0, 1, 1]

      fibonacci_numbers = fibonacci_numbers.add

      expect(fibonacci_numbers).to be_an_instance_of(FibonacciNumbers)
      expect(fibonacci_numbers.to_a).to eq [0, 1, 1, 2]

      fibonacci_numbers = fibonacci_numbers.add

      expect(fibonacci_numbers).to be_an_instance_of(FibonacciNumbers)
      expect(fibonacci_numbers.to_a).to eq [0, 1, 1, 2, 3]

      fibonacci_numbers = fibonacci_numbers.add

      expect(fibonacci_numbers).to be_an_instance_of(FibonacciNumbers)
      expect(fibonacci_numbers.to_a).to eq [0, 1, 1, 2, 3, 5]

      fibonacci_numbers = fibonacci_numbers.add

      expect(fibonacci_numbers).to be_an_instance_of(FibonacciNumbers)
      expect(fibonacci_numbers.to_a).to eq [0, 1, 1, 2, 3, 5, 8]
    end
  end

  describe 'add_until_length_reaches' do
    it 'メソッドを実行する前後の個数が正しいこと。' do
      fibonacci_numbers = FibonacciNumbers.generate(length: 2)

      expect(fibonacci_numbers.length).to eq 2

      fibonacci_numbers_with_added_values = fibonacci_numbers.add_until_length_reaches(10)

      expect(fibonacci_numbers_with_added_values.length).to eq 10
    end
  end

  describe '#to_a' do
    it 'フィボナッチ数列を構成する数字のリストが配列で返ってくること。' do
      fibonacci_numbers = FibonacciNumbers.generate
      expect(fibonacci_numbers.to_a).to eq [0, 1]

      fibonacci_numbers = fibonacci_numbers.add
      expect(fibonacci_numbers.to_a).to eq [0, 1, 1]
    end

    it 'FibonacciNumbersの@collectionの中身がそのまま返ってくるのではなく、cloneされた配列が返ってくること。' do
      fibonacci_numbers = FibonacciNumbers.generate

      expect(fibonacci_numbers.send(:collection).object_id).to eq fibonacci_numbers.send(:collection).object_id
      expect(fibonacci_numbers.send(:collection).object_id).not_to eq fibonacci_numbers.to_a.object_id
    end
  end
end
