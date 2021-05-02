<#
This script takes server names from 'd:\servers.txt' and changes app-pool identity of the IIS binding. On run time, a windows form will come up where user can enter app-pool name and new app pool credentials to renew.

#>#Invoking a Windows Form for user input

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Application Pool Identity Changer"

$objForm.Size = New-Object System.Drawing.Size(280, 300) 
$objForm.StartPosition = "CenterScreen"
$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {$x=$objTextBox.Text;$y=$objTextBox2.Text;$z=$objTextBox3.Text;$objForm.Close()}})
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape")
    {$objForm.Close()}})

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(30,230)
$OKButton.Size = New-Object System.Drawing.Size(100, 30)
$OKButton.Text = "Change Account" 
$OKButton.Add_Click({$x=$objTextBox.Text;$y=$objTextBox2.Text;$z=$objTextBox3.Text;$objForm.Close()})
$objForm.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size (150,230) 
$CancelButton.Size = New-Object System.Drawing.Size (100, 30)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()}) 
$objForm.Controls.Add($CancelButton)

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,20)
$objLabel.Size = New-Object System.Drawing.Size (280, 20) 
$objLabel.Text = "Enter the AppPool name:"
$objForm.Controls.Add($objLabel)
$objLabel = New-Object System.Windows.Forms.Label 
$objLabel.Location = New-Object System.Drawing.Size(10,20) 
$objLabel.Size = New-Object System.Drawing.Size(280, 20)
$objLabel.Text = "Enter the AppPool name:" 
$objForm.Controls.Add($objLabel)

$objTextBox = New-Object System.Windows.Forms.TextBox
$objTextBox.Location = New-Object System.Drawing.Size(10,40) 
$objTextBox.Size = New-Object System.Drawing.Size(250,20) = $objForm.Controls.Add($objTextBox)

$objLabel2  = New-Object System.Windows.Forms.Label 
$objLabel2.Location = New-Object System.Drawing.Size (10,80) 
$objLabel2.Size = New-Object System.Drawing.Size(280, 20) 
$objLabel2.Text = "Enter the new User Name:"
$objForm.Controls.Add($objLabel2)


$objTextBox2= New-Object System.Windows.Forms.TextBox 
$objTextBox2.Location = New-Object System.Drawing.Size(10, 100) 
$objTextBox2.Size = New-Object System.Drawing.Size(250, 20) 
$objForm.Controls.Add($objTextBox2)

$objLabel3 = New-Object System.Windows.Forms.Label
$objLabe13.Location = New-Object System.Drawing.Size (10,140) 
$objLabel3.Size = New-Object System.Drawing.Size(280, 20) 
$objLabe13.Text = "Enter the new Password: " 
$objForm.Controls.Add($objLabe13)

$objTextBox3 = New-Object System.Windows.Forms.TextBox 
$objTextBox3.Location = New-Object System.Drawing.Size (10,160) 
$objTextBox3.Size = New-Object System.Drawing.Size(250, 20) 
$objForm.Controls.Add($objTextBox3) 


$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()}) 
[void] $objForm.ShowDialog()

$x=$objTextBox.Text
$x | Out-File 'd: ServiceAccountAppPoolChange.txt'

$y=$objTextBox2.Text
$y | Add-Content 'd: \ServiceAccountAppPoolChange.txt'

$z=$objTextBox3. Text
$z | Add-Content 'd: \ServiceAccountAppPoolChange.txt'

$a = Get-Content "d:\servers.txt"


$objForm.Topmost = $True
$objForm.Add_Shown ({$obj Form. Activate()})
[void] $objForm.ShowDialog() 
$x=$objTextBox.Text 
$x | Out-File 'd: \ServiceAccount AppPoolChange.txt'

$y=$objTextBox2.Text 
$y | Add-Content 'd: \ServiceAccount AppPoolChange.txt'

$z=$objTextBox3. Text
$z | Add-Content 'd: \ServiceAccount AppPool Change.txt'

$a = Get-Content "d: \servers.txt"



# Changing App Pool Identity by passing values of variables $x, $y and $z 
Foreach ($server in $a){Copy-Item "d: \ServiceAccount AppPoolChange.txt" -Destination "\\$server\d$\ServiceAccount AppPoolChange.txt" -force}
Invoke-Command -ComputerName $a -ScriptBlock{
$p=(Get-Content d: \ServiceAccount AppPoolChange.txt) [0..0] 
$q-(Get-Content d: \ServiceAccount AppPoolChange.txt) [1..1]
$r=(Get-Content d: \ServiceAccount AppPoolChange.txt) [2..2]
Import-Module WebAdministration 
$appPool = get-childitem IIS:\AppPools\ -force Where-Object {$_.name -match "$p"}
$appPool.processModel.UserName = "$q"
$appPool.processModel.Password ="$r"
$appPool.processModel.identity ="3"
$appPool | Set-Item

#Showing the current details of App-pool credentials

$IISDetails = get-wmiobject -class Site -Authentication PacketPrivacy -Impersonation Impersonate -namespace "root/webadministration"
try{
$webapps = Get-WebApplication
$list = @()
foreach ($webapp in get-childitem IIS: \AppPools\)
{
$f=Senv: COMPUTERNAME
$name = "IIS:\AppPools\" + $webapp.name
$item=@{}
Start-Service -Name W3SVC
$item.WebAppName= $webapp.name 
$item.Username = $webapp.processModel.userName
$item.Password = $webapp.processModel.password 
$obj = New-Object PSObject Property $item
$list += $obj
}

$list | Format = Table -a -Property $f, "WebAppName", "Username", "Password" 
}
catch
{
$ExceptionMessage = "Error in Line: " + $_.Exception. Line + ". " +  $_.Exception.GetType().FullName +": " + $_.Exception.Message + " Stacktrace: "+$_.Exception.StackTrace
$ExceptionMessage 
}

Remove-Item d: \ServiceAccountAppPoolChange.txt
}