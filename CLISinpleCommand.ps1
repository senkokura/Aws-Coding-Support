# モジュールのインポート
#Import-Module AWS.Tools

# グローバル変数
#aaa
$commandInf = @{} 
$stopkeyword = @(
    "exit",
    "quit",
    "close",
    "finish"
)
$defaultVPC = ""
$defaultSubnet1 = ""
$defaultSubnet2 = ""
$defaultSecurityGroup = ""

# 関数定義
function Set-DefaultParameters {
    param (
        [string]$vpcId
    )

    # VPCの情報取得
    $vpc = Get-EC2Vpc -VpcIds $vpcId

    # サブネットの取得と選択
    $subnets = Get-EC2Subnet -VpcId $vpcId
    $subnetOptions = for ($i = 0; $i -lt $subnets.Count; $i++) {
        "{0} {1}({2})/ {3} / {4}" -f ($i+1), $subnets[$i].Tags | Where-Object {$_.Key -eq 'Name'} | Select-Object -ExpandProperty Value, $subnets[$i].SubnetId, $subnets[$i].AvailabilityZone, $subnets[$i].MapPublicIpOnLaunch
    }
    $subnetIndex = Read-Host -Prompt "chose default subnet 1 to number on flowing subnets:" -List $subnetOptions
    $defaultSubnet1 = ($subnets | Select-Object -Index ($subnetIndex - 1)).SubnetId

    # サブネット2の選択 (同様)
    # ...

    # セキュリティグループの選択 (同様)
    # ...

    # 変数のエクスポート
    $global:defaultVPC = $vpcId
    $global:defaultSubnet1 = $subnet1
    # ...

    # 結果表示
    Write-Host "default VPC        : $defaultVPC"
    Write-Host "default subnet 1   : $defaultSubnet1"
    # ...
}

#select and runtch command
function RuntchAWSCommand {
    param (
        $OptionalParameters
    )
    
    switch ($OptionalParameters["name"]){
        "ChangeVPC"{
            # VPC名からIDを取得
            $vpcs = Get-EC2Vpc -Filters @{Name='tag:Name';Values=$name}
            if ($vpcs.Count -eq 1) {
                $vpcId = $vpcs.VpcId
            } else {
                Write-Warning "VPC not found or multiple VPCs found."
                return
            }
        }
    }
}

# wait user input command.
# split input strings script and option paramaters, and runtch command
while ($true) {
    $command = Read-Host -Prompt "put command >"
    
    $commandParams = $command.Split(" ")
    $commandInf = @{}

    if ($commandParams.Count -eq 0) {
        Write-Host "Unkown format. use script is follow to"
        Write-Host "<script> <command> --<options> <values>"
    }else{
    
        # set Command name
        $commandInf["name"] = $commandParams[0]

        # when input word means break the loop than exit sprict
        if ($stopkeyword -contains $commandInf["name"] ){
            return
        }

        # set Command options
        for ($i = 1; $i -lt $commandParams.Count; $i += 2) {
            $key = $commandParams[$i]
            if ($commandParams[$i].Substring(0,2) -eq "--"){
                if ($i + 1 -lt $commandParams.Count) {
                    $key = $commandParams[$i].Substring(2, $commandParams[$i].length-2)
                    $value = $commandParams[$i + 1]
                    $commandInf[$key] = $value
                } else {
                    Write-Host "Parameter Error: not found value by '$key'"
                    break
                }
            } else {
                Write-Host "Unkown format. option name after at --, to follow:"
                Write-Host "~ --<option> <value>"
                break
            }
        }

        # conver scpict name and options to JSON
        $commandInfJson = ConvertTo-Json $commandInf

        # runtch command
        #RuntchAWSCommand($commandInf)
        RuntchAWSCommand($commandInfJson)
        
        #debug
        Write-Host $commandInfJson
    }
}






