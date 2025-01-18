# frozen_string_literal: true

require_relative './fibonacci_number'
require_relative './fibonacci_sequence_length'
require_relative './invalid_attribute_error'

# フィボナッチ数列を構成するフィボナッチ数のコレクションを管理するためのクラス。
#
# 1. ファーストクラスコレクション
# → コレクションに対するロジックを高凝集にするためのデザインパターン。
# → ロジックの重複を防ぎ、修正漏れに伴うバグ発生のリスクを低減する。
#
# 2. テスト駆動開発
# → 「レッド、グリーン、リファクタリング」のステップに分けて自動テストを実装することで、コードの品質を担保している。
# → また、テスト駆動開発によって、クラスのインターフェイスの「扱いやすさ」を検証しながら実装ができるため、インターフェイスの品質をある程度担保できるのもポイント。
#
class FibonacciNumbers
  FIRST_TERM  = FibonacciNumber.new(0).freeze # 第1項
  SECOND_TERM = FibonacciNumber.new(1).freeze # 第2項

  # 1. カプセル化
  # → 必要なデータや、手続きのみを外部に公開することで、必要以上に、モジュール間同士の結合度を上げないようにしている。
  # → インスタンス変数@collectionを読み取るためのゲッターメソッドを定義しているが、外部から参照する必要がないため、privateとして定義している。
  #
  private attr_reader :collection

  # 1. 完全コンストラクタ
  # → 確実に正常なデータを持つインスタンスを生成することで、そのデータを扱うインスタンスメソッド内で、エラーが発生する確率を下げることができる。
  # → 一度インスタンス変数に引数の値をセットした上で、validate_attributes!メソッドでデータをチェックし、異常があれば例外を投げることで、
  # → 後続のプログラムが実行されず、不正なインスタンスが生成されるのを防ぐことができる。
  # → その他、例外を発生させる際には、適したクラスとメッセージを指定することで、デバッグが容易になるよう工夫している。
  #
  # 2. 不変オブジェクト
  # → インスタンスのデータの書き換えを許す構造にしてしまうと、ロジックを追うのが大変な上、意図しないバグを誘発する可能性もあるため、値の書き換えを許可しない「不変オブジェクト」を生成するよう定義。
  # → ※ コンストラクタ最終行に`freeze`と記述することで、インスタンスの中身の書き換えができない「不変オブジェクト」を生成できるようになる。
  # → なお、パフォーマンスに問題がある場合等、「可変オブジェクト」として定義した方が適しているケースがある点に注意。
  #
  def initialize(collection = [FibonacciNumbers::FIRST_TERM, FibonacciNumbers::SECOND_TERM])
    @collection = collection

    validate_attributes!

    freeze
  end

  # 1. 目的駆動命名
  # → 目的を表す命名にすることによって、プログラムの意図が明確になり、可読性が大きく向上する。
  #
  def self.generate(length: 2)
    fibonacci_sequence_length = FibonacciSequenceLength.new(length)

    new.add_until_length_reaches(fibonacci_sequence_length.to_i)
  end

  # 1. 目的駆動命名
  # → 目的を表す命名にすることによって、プログラムの意図が明確になり、可読性が大きく向上する。
  #
  def add
    calculated_number                      = collection.last(2).sum(&:to_i)
    fibonacci_number_to_add                = FibonacciNumber.new(calculated_number)
    collection_with_fibonacci_number_added = collection.dup + [fibonacci_number_to_add]

    FibonacciNumbers.new(collection_with_fibonacci_number_added)
  end

  # 1. 目的駆動命名
  # → 目的を表す命名にすることによって、プログラムの意図が明確になり、可読性が大きく向上する。
  #
  def add_until_length_reaches(length)
    new_fibonacci_numbers = self
    new_fibonacci_numbers = new_fibonacci_numbers.add until new_fibonacci_numbers.length >= length
    new_fibonacci_numbers
  end

  def length
    collection.length
  end

  def to_a
    collection.dup.map(&:to_i)
  end

  private

  def validate_attributes!
    validate_collection!
  end

  def validate_collection!
    raise InvalidAttributeError, 'Attribute `collection` is required.'                                                           if collection.nil?
    raise InvalidAttributeError, 'Attribute `collection` must be an instance of Array Class, including FibonacciNumber Objects.' unless collection.is_a?(Array) && collection.all? { |fibonacci_number| fibonacci_number.is_a?(FibonacciNumber) }
    raise InvalidAttributeError, 'Attribute `collection` must contain 0 and 1 for the first two elements.'                       unless collection.first(2) == [FibonacciNumbers::FIRST_TERM, FibonacciNumbers::SECOND_TERM]
  end
end

# その他
# 1. クラス内において、大きな意味を持つリテラルは、定数として定義することで、可読性が向上する。
# → FIRST_TERM
# → SECOND_TERM
#
# 2. @collectionはそのまま返さず、コピーした配列を返す。
# → FibonacciNumbers#to_a
# → 配列はミュータブルなオブジェクトなので、@collectionをそのまま返してしまうと、外部からデータの書き換えができてしまい、ロジックを追うのが大変になる上、バグの混入リスクが高まる。
# → そのため、`dup`メソッドを使用し、@collectionそのものではなく、@collectionのコピーを回避することで、上記のリスクを回避している。
