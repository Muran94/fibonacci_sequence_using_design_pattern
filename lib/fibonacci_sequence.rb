# frozen_string_literal: true

require_relative './fibonacci_numbers'
require_relative './fibonacci_sequence_length'

# フィボナッチ数列を表すクラス
#
# 1. 高凝集
# → 関連するデータとロジックを単一のクラスにまとめることで、ロジックの重複に伴う様々なリスクを低減できる。
# → 今回のケースでは、高凝集にすることで得られる恩恵は少ないが、ありがちなのは、消費税を計算するためのロジックが、
# 適切なクラスに実装されていないために、同じようなロジックがあちこちに実装されてしまい、仕様変更時に、修正漏れに伴うバグが発生すること。
#
# 2. テスト駆動開発
# → 「レッド、グリーン、リファクタリング」のステップに分けて自動テストを実装することで、コードの品質を担保している。
# → また、テスト駆動開発によって、クラスのインターフェイスの「扱いやすさ」を検証しながら実装ができるため、インターフェイスの品質をある程度担保できるのもポイント。
#
class FibonacciSequence
  # 1. カプセル化
  # → 必要なデータや、手続きのみを外部に公開することで、必要以上に、モジュール間同士の結合度を上げないようにしている。
  # → インスタンス変数@numberを読み取るためのゲッターメソッドを定義しているが、外部から参照する必要がないため、privateとして定義している。
  # → また、今回のユースケースでは、`.new`メソッドを直接呼び出す必要は無いので、プライベートな特異メソッドとして定義している。
  #
  private attr_reader :fibonacci_numbers

  private_class_method :new

  # 1. 完全コンストラクタ
  # → 確実に正常なデータを持つインスタンスを生成することで、そのデータを扱うインスタンスメソッド内で、エラーが発生する確率を下げることができる。
  # → 今回は、コンストラクタ上部に、不正値を検知する仕組みを設け、不正値であった場合に例外を発生させている。
  # → 後続のプログラムが実行されず、不正なインスタンスが生成されるのを防ぐことができる。
  # → その他、例外を発生させる際には、適したクラスとメッセージを指定することで、デバッグが容易になるよう工夫している。
  #
  # 2. 不変オブジェクト
  # → インスタンスのデータの書き換えを許す構造にしてしまうと、ロジックを追うのが大変な上、意図しないバグを誘発する可能性もあるため、値の書き換えを許可しない「不変オブジェクト」を生成するよう定義。
  # → ※ コンストラクタ最終行に`freeze`と記述することで、インスタンスの中身の書き換えができない「不変オブジェクト」を生成できるようになる。
  # → なお、パフォーマンスに問題がある場合等、「可変オブジェクト」として定義した方が適しているケースがある点に注意。
  #
  def initialize(fibonacci_numbers = FibonacciNumbers.new)
    raise ArgumentError, 'Argument `fibonacci_numbers` is required.'                                   if fibonacci_numbers.nil?
    raise ArgumentError, 'Argument `fibonacci_numbers` must be an instance of FibonacciNumbers class.' unless fibonacci_numbers.is_a?(FibonacciNumbers)

    @fibonacci_numbers = fibonacci_numbers

    freeze
  end

  def self.generate(length: 2)
    fibonacci_sequence_length = FibonacciSequenceLength.new(length)
    fibonacci_numbers         = FibonacciNumbers.generate(length: fibonacci_sequence_length.to_i)

    new(fibonacci_numbers)
  end

  def length
    fibonacci_numbers.length
  end

  def to_a
    fibonacci_numbers.to_a
  end

  def to_s
    to_a.join(', ')
  end
end

# その他
#
# キーワード引数を使用することで、プログラムの可読性向上を図っている。
# → FibonacciSequence.generate
# → キーワード引数にしないと、引数に渡された数値の意味を読み解くためにコードの中身を読まなければならなくなる。可読性の低下を招くので、ここでは記述量が若干増えるかもしれないが、キーワード引数を渡すよう定義している。
