##########################################################
# セキュリティグループを作成
##########################################################
aws ec2 create-security-group \
--group-name <セキュリティグループ名> \
--description <説明（拘りなければセキュリティグループ名)> \
--vpc-id vpc-xxxxx \
--tag-specifications "ResourceType=security-group,Tags=[{Key=Name, Value=<セキュリティグループ名>}]"


##########################################################
# インバウンドルール／アウトバウンドの追加
##########################################################
#インバウンドルールを追加1
# SSHのアクセスを許可する場合
aws ec2 authorize-security-group-ingress \
--group-id <セキュリティグループのID> \
--protocol tcp \
--port 22 \
--cidr <IPの範囲> 


#インバウンドルールを追加1(ip-permissionsを使って指定)
#--ip-permissionsを使って指定
#aws ec2 authorize-security-group-ingress \
#--group-id <セキュリティグループのID> \
#--ip-permissions '{"FromPort":22, "ToPort":22,"IpProtocol":"tcp","IpRanges":[{"CidrIp":"<CIDR>","Description":"<説明>"}]}'


#インバウンドルールを追加2
#他セキュリティグループからのhttps接続を許可する場合
aws ec2 authorize-security-group-ingress \
--group-id <セキュリティグループのID> \
--protocol tcp \
--port 443 \
--source-group <送信元のセキュリティグループのID>

#インバウンドルールを追加2(ip-permissionsを使って指定)
#--ip-permissionsを使って指定
#aws ec2 authorize-security-group-ingress \
#--group-id <セキュリティグループのID> \
#--ip-permissions '{"FromPort":443, "ToPort":443,"IpProtocol":"tcp","UserIdGroupPairs":[{"GroupId":"<GroupId>","Description":"<説明>"}]}'


#アウトバウンドルールを追加
#icmpのアクセスを許可する場合
aws ec2 authorize-security-group-egress \
--group-id <セキュリティグループのID> \
--protocol icmp \
--port all \
--cidr <IPの範囲> 


##########################################################
#インバウンドルールの修正
##########################################################
#※一度削除して、再作成する必要がある
#既存のルールを削除
aws ec2 revoke-security-group-ingress \
--group-id <セキュリティグループのID> \
--protocol tcp \
--port 22 \
--cidr <IPの範囲> 

#セキュリティグループルールIDがわかっている場合
#aws ec2 revoke-security-group-ingress \
#--group-id <セキュリティグループのID> \
#--security-group-rule-id <セキュリティグループルールのID> 


# 新しいルールを作成
# SSHのアクセスを許可する場合
aws ec2 authorize-security-group-ingress \
--group-id <セキュリティグループのID> \
--protocol tcp \
--port 22 \
--cidr <IPの範囲> 

##########################################################
#セキュリティグループの削除
##########################################################
aws ec2 delete-security-group --group-id <セキュリティグループのID>