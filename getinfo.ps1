# Get Hardware and Management interface information
# =================================================
Get-VMHost |Sort Name |Get-View |
Select Name,
@{N=“Serial number“;E={($_.Hardware.SystemInfo.OtherIdentifyingInfo | where {$_.IdentifierType.Key -eq “ServiceTag”}).IdentifierValue}},
@{N=“Manufacturer“;E={$_.Config.Product.Vendor}},
@{N=“Operating System“;E={$_.Config.Product.Name}},
@{N=“OS Version“;E={$_.Config.Product.Version + “ - Build “ + $_.Config.Product.Build}},
@{N=“Type“;E={$_.Hardware.SystemInfo.Vendor + “ “ + $_.Hardware.SystemInfo.Model}},
@{N=“CPU core count“;E={$_.Hardware.CpuInfo.NumCpuCores}},
@{N=“CPU count“;E={$_.Hardware.CpuInfo.NumCpuPackages}},
@{N=“CPU speed (MHz)“;E={[math]::round($_.Hardware.CpuInfo.Hz / 1000000, 0)}},
@{N=“CPU type“;E={$_.Hardware.CpuPkg[0].Description}},
@{N=“IP Address“;E={($_.Config.Network.Vnic | ? {$_.Device -eq "vmk0"}).Spec.Ip.IpAddress}},
@{N=“RAM (MB)“;E={“” + (([math]::round($_.Hardware.MemorySize / 1GB, 0))* 1024)}} | Export-Csv c:\temp\Filename.csv
