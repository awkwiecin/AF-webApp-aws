echo "Deploy app to ecr..."
Initialize-AWSDefaultConfiguration -ProfileName afAWS -Region eu-central-1
$loginCommand = Get-ECRLoginCommand -Region eu-central-1
Invoke-Expression $loginCommand.Command
#docker build -t af-ecr .
docker build -t -p 8080:80 af-ecr -f ./AF-webApp-aws/Dockerfile .
docker tag af-ecr:latest 836906079004.dkr.ecr.eu-central-1.amazonaws.com/af-ecr-tf:latest
docker push 836906079004.dkr.ecr.eu-central-1.amazonaws.com/af-ecr-tf:latest

