# aws sdkをインポート
import boto3

# 翻訳クライアントを作成
translate = boto3.client("")

# 変換する文字を設定
text = "今日の岡山の天気は雪です。路面の凍結や、交通機関の遅れに気を付けましょう。"

#　言語を設定

# 日本語から、英語に変換
response =translate.translate_text()

# 結果を表示
print("翻訳結果：", response)


# Next Srtep
# responseはjson形式で返ってくるため、翻訳した値「だけ」を取得する

