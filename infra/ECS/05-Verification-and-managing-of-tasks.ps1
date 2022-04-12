echo "Verification and management of FARGATE tasks..."

#Get a list of tasks running in the cluster
Get-EcsTaskList -Cluster af-ecs-cluster
#Get details of a particular task
#This will show blank (it has no specifics)
Get-EcsTaskDetail -Cluster af-ecs-cluster -Task arn:aws:ecs:eu-central-1:836906079004:task/af-ecs-cluster/62a9b67c37b24c1ab0b2c91e6f9d20f2
#Using an object helps us to specifically ask for details -> this set will show the info we need
$myTask = Get-EcsTaskDetail -Cluster af-ecs-cluster -Task arn:aws:ecs:eu-central-1:836906079004:task/af-ecs-cluster/62a9b67c37b24c1ab0b2c91e6f9d20f2
$myTask.Tasks

#Stop task
Stop-ECSTask -Task arn:aws:ecs:eu-central-1:836906079004:task/af-ecs-cluster/62a9b67c37b24c1ab0b2c91e6f9d20f2 -Cluster af-ecs-cluster