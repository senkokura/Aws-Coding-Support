######################################################
# SSMできそうなEC2を検索する
######################################################
#EC2
#※SSM接続するには、「AmazonSSMManagedInstanceCore」を
#許可したロールが必要。
#少なくともロールがついてないEC2は対象外
aws ec2 describe-instances \
--filters "Name=instance-state-name,Values=running" \
--query 'Reservations[*].Instances[*].{h1_InstanceId:InstanceId,h2_Name:Tags[?Key==`Name`].Value | [0],h3_State:State.Name ,h4_PublicIp:PublicIpAddress,h5_PrivateIp:PrivateIpAddress,h6_role:IamInstanceProfile.Arn}' \
--output table


######################################################
# SSM接続を試みる
######################################################
aws ssm start-session --target <調べたインスタンスID>


######################################################
# SSMセッションを閉じる
######################################################
exit