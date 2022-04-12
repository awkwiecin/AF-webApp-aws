
echo "Check modules info..."
Get-Module -Name AWSPowerShell -ListAvailable
Get-Module -Name AWSPowerShell.NetCore -ListAvailable
Get-Module -Name AWS.Tools.Common -ListAvailable

$a = Get-Module AWSPowerShell
Remove-Module -ModuleInfo $a