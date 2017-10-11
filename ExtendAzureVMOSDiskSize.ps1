Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId YOUR_SUBSCRIPTION_GUID
$rgName = 'YOUR_RESOURCE_GROUP_NAME'
$vmName = 'YOUR_VM_NAME'
$vmOsDisc = 'YOUR_VM_OS_DISC'
$vm = Get-AzureRmVM -ResourceGroupName $rgName -Name $vmName
$vm.StorageProfile.OSDisk.DiskSizeGB = 1023

Stop-AzureRmVM -ResourceGroupName $rgName -Name $vmName
Remove-AzureRmVMDataDisk -VM $vm -Name $vmOsDisc
Update-AzureRmVM -ResourceGroupName $rgName -VM $vm
Add-AzureRmVMDataDisk -VM $vm -Name $vmOsDisc
Start-AzureRmVM -ResourceGroupName $rgName -Name $vmName
