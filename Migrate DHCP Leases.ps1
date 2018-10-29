$SourceA_DHCPServer = "DHCP Server1"
$DestinationDHCPServer = "DHCP Server2"
$ScopeOptionsServerA = @()


$ScopeToMigrateFrom   = "192.168.1.1"
$ScopeToMigrateTo   = "192.168.1.1"


#Get the Leases off Scope, but exclude reservations
$LeasesSourceServerA = Get-DhcpServerv4Lease -ComputerName $SourceA_DHCPServer -ScopeId $ScopeToMigrateFrom -AllLeases |Where-Object {($_.AddressState -notlike "*Reservation*")}

Write-Host "Leases"
foreach ($item in $LeasesSourceServerA)
{
   $item | Add-DhcpServerv4Lease -ComputerName $DestinationDHCPServer -ScopeId $ScopeToMigrateTo 
   Write-Host $item.IPAddress $item.clientID 
}