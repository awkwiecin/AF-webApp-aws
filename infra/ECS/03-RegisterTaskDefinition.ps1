echo "Register task definition..."

#Get addional info about the command...
#Get-Help -Name Register-ECSTaskDefinition

#Get definitions of Network.Mode types
#[Amazon.ECS.NetworkMode] | gm -Static -MemberType Properties

#Invoke task definition registration (the system will ask about the specifics)
#Register-ECSTaskDefinition -NetworkMode awsvpc -cont

#define task definition
$C1 = [Amazon.ECS.Model.ContainerDefinition]::new()
$C1.Image = 'docker.io/library/nginx'
$C1.Name = 'webserver'
$C1.Memory = 1024
$C1.Cpu = 512

#run it
#Register-ECSTaskDefinition -NetworkMode awsvpc -ContainerDefinition $C1 -Family afnginx -RequiresCompatibility FARGATE -Memory 1024 -Cpu 512

#Do the same with powershell splatting
$ECSParams =@{
    NetworkMode = 'awsvpc'
    ContainerDefinition = $C1
    Family = 'afnginx' 
    RequiresCompatibility = 'FARGATE'
    Memory = 1024
    Cpu = 512
} 
Register-ECSTaskDefinition @ECSParams
