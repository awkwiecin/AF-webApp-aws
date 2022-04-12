#Execute from main sln folder
echo "Building image..."
#path from sln folder
./infra/ECR/10-AF-ecr-deploy
echo "Image deployed to ECR"
#path from sln folder
./infra/ECS/10-AF-DeployAFHelloApp
echo "Image deployed to ECS"