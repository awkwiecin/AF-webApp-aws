echo "Building docker image..."
docker build -t af-ecr -f ./AF-webApp-aws/Dockerfile .
echo "Running docker container..."
Start-Job{docker run -p 8080:80 af-ecr}