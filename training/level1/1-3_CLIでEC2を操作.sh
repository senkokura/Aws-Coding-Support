################################################################## 
# 2-3_4CLIでEC2を操作
##################################################################
## EC2操作
# インスタンス一覧表示(起動中のみ)
aws ec2 describe-instances \
--filters "Name=instance-state-name,Values=running" \
--query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress,PrivateIpAddress,Tags[?Key==`Name`].Value | [0]]' \
--output table

#インスタンスの停止
aws ec2 stop-instances --instance-ids <インスタンスID> \
--query 'StoppingInstances[*].{InstanceId: InstanceId, State: join(`⇒`, [PreviousState.Name,CurrentState.Name])}' \
--output table

#インスタンスの起動
aws ec2 start-instances --instance-ids <インスタンスID> \
--query 'StartingInstances[*].{InstanceId: InstanceId, State: join(`⇒`, [PreviousState.Name,CurrentState.Name])}' \
--output table
