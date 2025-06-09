# Azure Backup and Replication Demo Script
# Requires Azure PowerShell module

# Login to Azure
Connect-AzAccount

# Define variables
$resourceGroup = "azdrcap-centralus-rg"
$vaultName = "azdrcapRecoveryVault"
$vmName = "Test-Server01"
$policyName = "azdrcapReplicationPolicy"

# Create a Recovery Services Vault
New-AzRecoveryServicesVault -ResourceGroupName $resourceGroup -Name $vaultName -Location "Central US"

# Enable replication for a VM
$vault = Get-AzRecoveryServicesVault -ResourceGroupName $resourceGroup -Name $vaultName
$policy = Get-AzRecoveryServicesReplicationPolicy -VaultId $vault.ID -Name $policyName
$vm = Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName

Enable-AzRecoveryServicesReplicationProtection -VaultId $vault.ID -PolicyId $policy.ID -VMId $vm.ID

Write-Output "Backup and replication setup complete!"