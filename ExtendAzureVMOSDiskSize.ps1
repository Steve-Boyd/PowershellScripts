Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId YOUR_SUBSCRIPTION_GUID
$rgName = 'YOUR_RESOURCE_GROUP_NAME'
$vmName = 'YOUR_VM_NAME'
$vm = Get-AzureRmVM -ResourceGroupName $rgName -Name $vmName
Stop-AzureRmVM -ResourceGroupName $rgName -Name $vmName
$vm.StorageProfile.OSDisk.DiskSizeGB = 1023
Update-AzureRmVM -ResourceGroupName $rgName -VM $vm
Start-AzureRmVM -ResourceGroupName $rgName -Name $vmName