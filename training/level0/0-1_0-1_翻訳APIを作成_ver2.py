##################################################
#AWS TranselateのAPIを呼び出し、日本語を英語に翻訳
##################################################
# AWS SDKのパッケージをインポート
import boto3

##変更箇所1 : パッケージを追加
import sys

# AWS Transelateのクライント（client）を準備
translate = boto3.client('translate')

##変更箇所2 : コマンド実行時に渡した値を取得
#翻訳する日本語を格納
if len(sys.argv) > 1:
    text = sys.argv[1]
else:
    text = "今日の岡山の天気は曇り"

##変更箇所2 : ここまで

#クライアントのAPIに文字を渡して結果を変数に格納
result = translate.translate_text(Text=text, SourceLanguageCode="ja", TargetLanguageCode="en")

#返ってきた結果を画面に出力する
print(result['TranslatedText'])
