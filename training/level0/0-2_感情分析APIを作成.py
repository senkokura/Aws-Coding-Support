# aws sdkをインポート
import boto3

# Comprehendのクライアントを作成
comprehend = boto3.client('comprehend')

# 解析するテキストを設定
text = "0-1で翻訳した英語をいれる"

# 言語を設定
language = 'en'

# テキストを解析
response = comprehend.・・・()

# 結果を表示
# responseはjson形式で返ってくるため、「Sentiment」だけ表示させたい。
# Sentiment:Positive, Negative, Neutral, Mixedのいずれかが返ってくる
print("感情の分析結果：", response)
