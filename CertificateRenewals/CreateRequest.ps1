#Defining the Peth of certificate repository 
$RootPath = 'D:\CERTIFICATES\CertificateRepository'
cd $RootPath

#Specifying the certificate to be renewed

$Certificate = Read-Host "Please enter Certificate name"

#Creating a folder with current date and time as name, in which certificate request will be stored 
cd $Certificate 
$Certlocation = New-Item ItemType Directory -Path ".\$((Get-Date). Tostring('yyyy-MM-dd, hh.mm'))"

cd $Certlocation

#Creating the CSR File of certificate

certreq -new "D:\CERTIFICATES\CertificateRepository\$certificate\Template.inf" CSR.txt

Invoke-Item .\CSR.txt

#Exporting request pfx to a location 
Set-Location cert:\LocalMachine\REQUEST 
Get-ChildItem | Where-Object { $_.FriendlyName -like $Certificate } | Format-Table -wrap FriendlyName, subject, notbefore, notafter

$mypwd = ConvertTo-SecureString -String "<certificatePassword>" -Force -AsPlainText 
Get-Childitem | Where-Object { $_.Friendlytiame -like $Certificate } | Export-PfxCertificate -FilePath $certlocation\$certificate.pfx -Password $mypwd 
Write-Host "Your Certificate request has been created and it can be found in "`n`n$CertLocation `n`n"..Opening CSR file now" -Foregroundcolor Yellow -BackgroundColor DarkGray
Read-Host -Prompt "Press Enter to exit exit"

###submit the CSR and corresponding portal and save the replies (both certificate and chain) in Scert Location, Save the certificate file as cart.cereas