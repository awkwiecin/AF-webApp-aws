echo "AF1 - Register task definition..."
#define task definition
echo "Define parameters for task definition..."
$C1 = [Amazon.ECS.Model.ContainerDefinition]::new()
$C1.Image = '836906079004.dkr.ecr.eu-central-1.amazonaws.com/af-ecr:latest'
$C1.Name = 'af-hello-from-api'
$C1.Memory = 512
$C1.Cpu = 512

$ECSParams =@{
    NetworkMode = 'awsvpc'
    ContainerDefinition = $C1
    Family = 'af-hello' 
    RequiresCompatibility = 'FARGATE'
    Memory = 1024
    Cpu = 512
    ExecutionRoleArn = 'ecsTaskExecutionRole'
}
#Register Task Definition 
echo "Register task definition - Run..."
Register-ECSTaskDefinition @ECSParams

echo "AF1 - Define and run fargate task..."
#Define Task run params
echo "Define parameters for fargate task..."
$FargateTaskParams = @{
    Cluster = 'af-ecs-cluster'
    Count = 1
    LaunchType = 'FARGATE'
    TaskDefinition = 'af-hello'
    AwsvpcConfiguration_AssignPublicIp = 'ENABLED'
    AwsvpcConfiguration_SecurityGroup = 'sg-044fffc5f16b5f8dd'
    AwsvpcConfiguration_Subnet = 'subnet-0c5ab4a1499db9f85'
}
echo "ECS Fargate Task - Run..."
New-ECSTask @FargateTaskParams
