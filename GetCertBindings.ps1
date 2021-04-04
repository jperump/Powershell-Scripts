<# following code fetches certificates that are currently bound to IIS webservice. 
You can pass in a number of days within which to check the expiry for. #>

$DaysToExpiration = read-host 'Enter days remaining to expiry to check for'

$expirationDate = (Get-Date).AddDays($DaysToExpiration)

$sites = Get-Website | % { $ _. Name } $certs = Get-ChildItem IIS:SSLBindings | ? {

    $sites -contains $_.Sites. Value

} | % { $_. Thumbprint }

Get-ChildItem CERT: LocalMachine/My | ? {

    $certs -contains $_. Thumbprint -and $_.NotAfter -lt $expirationDate } | Format-Table -wrap FriendlyName, notbefore, notafter, Thumbprint

