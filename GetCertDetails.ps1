#Following snippet gets you the certificates that are in the certificate store of the machine, by providing the common name to search for.
Set-Location cert:\LocalMachine\My
$CommonName = #<<certificate's common name">>
Get-ChildItem Where-Object { $_.FriendlyName -like $CommonName } | Format-Table wrap FriendlyName, subject, notbefore, notafter, certificate template information | Out-File d:\certificate.txt -Append


####################################

#for getting certificate with a thumbprint value

Set-Location -Path "cert:\LocalMachine\My" Scert - (Get-ChildItem -Path <<thumbprint>>)
$cert

####################################

#following snippet fetches the Signatue Hashing Algorithm of certificates installed in a given list of servers

$server = Get-Content "d: \servers.txt" 

Foreach ($server in $server) {

    Invoke-Command -ComputerName $server -ScriptBlock

    { 
        $machine = $env: COMPUTERNAME
    
        $Cert = Get-ChildItem Cert:\LocalMachine \My\ | Select -First 100
    
        $certificate = foreach ($certificate in $Cert) {
            $name = $certificate. FriendlyName
    
            $SHA = $certificate.SignatureAlgorithm.FriendlyName 
            if ($certificate. FriendlyName -ne "") { 
                Write-Host $env:COMPUTERNAME $SHA $name
            } 
        } 
    } 

}
