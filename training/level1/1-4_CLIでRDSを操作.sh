#####################################################################
# CLIでRDSを操作する
#####################################################################
# RDSインスタンスの一覧を取得
aws rds describe-db-instances \
--query ・・・

# RDSを停止する
aws rds stop-db-instance --db-instance-identifier <DBインスタンス識別子>

# RDSを起動する
aws rds start-db-instance --db-instance-identifier <DBインスタンス識別子>

# RDSインスタンスのスナップショット作成
aws rds create-db-snapshot \
--db-instance-identifier <DBインスタンス識別子> \
--db-snapshot-identifier <スナップショット識別子>
