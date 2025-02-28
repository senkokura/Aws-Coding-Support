######################################################
# とりあえず、全量取得
######################################################
#「aws ec2 describe-」までは固定。
#「-」の後に複数形のリソース名（<リソース名>s、<リソース名>es）をつける
# VPC
aws ec2 describe-vpcs

#EC2
aws ec2 describe-instances

#RDS
aws rds describe-db-instances
aws rds describe-db-clusters

#セキュリティグループ
aws ec2 describe-security-groups

# EIP
aws ec2 describe-addresses

#AMI
aws ec2 deregister-image

#スナップショット(EC2)
aws ec2 describe-snapshots

#スナップショット(RDS)
aws rds describe-db-snapshots


######################################################
# 形式を変えて出力する
# \セキュリティグループを例に挙げて説明
######################################################
# \ はコマンドを開業するときに使用（一行で各場合は不要）
#---query　オプションを追加して、出力項目を絞る
# --output オプションを追加して、出力形式を変更する（json, table, textか選択可能）
aws ec2 describe-security-groups \
--query '' \
--output table


#別解（CLIの出力結果をパイプラインでつないで、別のコマンドで成型加工）
#--queryでやっていることをjqというコマンド使ってやる
# \ はコマンドを改行するときに使用（一行で各場合は不要）
aws ec2 describe-security-groups  \
| jq -r ''


######################################################
# 対象を絞り込む
######################################################
# IDで絞る
# コマンドによってはIDで絞れなかったりするので、
# その場合は、後述する「--filter」を使う
aws ec2 describe-security-groups --group-ids <セキュリティグループのID>

#名前で絞る
aws ec2 describe-security-groups --filter "Name=group-name, Values=<セキュリティグループの名前>"

#番外編
#関連付けされてないEIPを絞る
#EIPが関連付けされている場合、出力結果に「AssociationId」の項目が含まれる。
#そのことを逆手に取り、その項目が含まれていないことを条件にして絞る
aws ec2 describe-addresses --query 'Addresses[?AssociationId==null]'
