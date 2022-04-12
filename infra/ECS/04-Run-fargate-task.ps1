echo "Run fargate task..."

#Show cmdlets corelated with ecs and tasks
#echo "Cmdlets for ecs&tasks..."
#Get-AwsCmdletName -Service ecs | ? CmdletName -match task

#Get list of ECS clusters
#echo "List of available clusters..."
#Get-ECSClusterList
#Get-ECSClusterDetail -Cluster arn:aws:ecs:eu-central-1:836906079004:cluster/af-ecs-cluster
#Get-ECSClusterDetail -Cluster arn:aws:ecs:eu-central-1:836906079004:cluster/af-ecs-cluster -Include SETTINGS | Select-Object *

#using VPC = 'vpc-0fead40e24304ce5f'
$FargateTaskParams = @{
    Cluster = 'af-ecs-cluster'
    Count = 1
    LaunchType = 'FARGATE'
    TaskDefinition = 'afnginx'
    AwsvpcConfiguration_AssignPublicIp = 'ENABLED'
    AwsvpcConfiguration_SecurityGroup = 'sg-044fffc5f16b5f8dd'
    AwsvpcConfiguration_Subnet = 'subnet-0c5ab4a1499db9f85'
}

New-ECSTask @FargateTaskParams
