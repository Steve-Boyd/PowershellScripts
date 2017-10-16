# Script to re-instate functionality required in Google Chrome for it to work properly for developers

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

$RegistryPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$DisabledPlugins = $RegistryPath + "\DisabledPlugins"
$InstallBlacklist = $RegistryPath + "\ExtensionInstallBlacklist"
$URLBlacklist = $RegistryPath + "\URLBlacklist"
$GoogleUpdate = "HKLM:\SOFTWARE\Policies\Google\Update"
$Google = "HKLM:\SOFTWARE\Policies\Google"

echo "Enabling plug-ins for Google Chrome"
if (Test-Path $DisabledPlugins) {
  Remove-Item $DisabledPlugins
}
#else {
#  echo "did not find " + $DisabledPlugins
#}

if (Test-Path $InstallBlacklist) {
  Remove-Item $InstallBlacklist
}
#else {
#  echo "did not find " + $InstallBlacklist
#}

if (Test-Path $URLBlacklist) {
  Remove-Item $URLBlacklist
}
#else {
#  echo "did not find " + $URLBlacklist
#}

echo "Enabling automatic updates"
Set-Location -Path $GoogleUpdate
$Items = Get-Item .\

#echo "found " + $Items.ValueCount

foreach ($Item in $Items.GetValueNames()) {
#    echo $Item
    if ($Item.StartsWith("Update")) {
#       echo "starts with update" 
       Set-ItemProperty -Name $Item -Path $GoogleUpdate -Value 1
    }
}

#pause 
