# 概要
- 初歩的なプログラミングの定番問題であるフィボナッチ数列を出力する実装において、デザインパターンを用いることでどの程度ブラッシュアップできるか検証。
- なお、一般的に想定される実装方法を下記に記載する。

```ruby
def generate_fibonacci_numbers(fibonacci_numbers, length)
  length.times do |n|
    if (n == 0 || n == 1)
      fibonacci_numbers << n
    else
      fibonacci_numbers << fibonacci_numbers[n - 2] + fibonacci_numbers[n - 1]
    end
  end

  fibonacci_numbers
end

fibonacci_numbers = []
fibonacci_numbers = generate_fibonacci_numbers(fibonacci_numbers, 15)
p fibonacci_numbers
=> [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]

```

# 技術選定
プログラム実装
- Ruby 3.3.6

自動テストの実装
- RSpec

# 使用しているデザインパターン
- 高凝集疎結合
- 値オブジェクト
- 完全コンストラクタ
- 不変オブジェクト
- カプセル化
- 早期return
- 目的駆動命名（『良いコード/悪いコードで学ぶ設計入門』の著者である仙塲さんの造語）

# 設計における備考
設計における詳細事項は、下記ファイルにコメントとして記載してある。
- lib/fibonacci_sequence.rb # フィボナッチ数列
- lib/fibonacci_numbers.rb # フィボナッチ数列を構成する数値のコレクション
- lib/fibonacci_number.rb # フィボナッチ数列を構成する各数値
