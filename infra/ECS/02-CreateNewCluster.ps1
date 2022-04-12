echo "Create new cluster..."
 help New-ECS
 New-ECSCluster -ClusterName AF-ecs-cluster
 Remove-ECSCluster -Cluster AF-ecs-cluster -Force
 New-ECSCluster -ClusterName af-ecs-cluster