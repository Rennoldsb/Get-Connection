$Connections = Get-NetTCPConnection -State Listen | ?{$_.RemoteAddress -notcontains "127.0.0.1" -and $_.LocalPort -lt 10000}
$csv = Import-Csv C:\Users\PC\Desktop\service-names-port-numbers.csv


foreach($Connection in $Connections){
$port = $Connection.LocalPort
$Description = Get-Process -id  $Connection.OwningProcess | Select-Object -ExpandProperty Description
$ActivePort = $csv | where {$_."Port Number" -eq "$port" -and $_."Transport Protocol" -eq "tcp"} | Select-Object -expa "Description"
if ($Description -ne $null){
$Description = "System Process"
Write-Host "$Description is listening on port $port ($ActivePort)"
}}