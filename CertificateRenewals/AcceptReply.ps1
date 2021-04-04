
#go to certificate location

$Certificate= Read-Host "Please enter the Certificate Name "
$CertLocation = Read-Host "Please enter the Certificate Location" 
cd $certlocation

#Accpet CA reply and for final certificate

certreq -accept certnew.p7b

#Export Final certificate to location

New-Item = ItemType Directory -Path "Scertlocation\Final" 
Set-Location cert:\LocalMachine\My
Get-ChildItem| Where-Object {$_.FriendlyName -like $Certificate} |Format-Table -wrap FriendlyName, subject, notbefore, notafter
$mypwd = ConvertTo-SecureString -String "<certificatePassword>" -Force -AsPlainText 
Get-Childitem | Where-Object { $_.Friendlytiame -like $Certificate } | Export-PfxCertificate -FilePath $certlocation\Final\$certificate.pfx -Password $mypwd 
Write-Host "Your Certificate request has been created and it can be found in "`n`n$CertLocation\Final `n`n"..Opening CSR file now" -Foregroundcolor Yellow -BackgroundColor DarkGray
Read-Host -Prompt "Press Enter to exit exit"




