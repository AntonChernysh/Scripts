#Generated Form Function
function GenerateForm {

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$WSForm = New-Object System.Windows.Forms.Form
$GoButton = New-Object System.Windows.Forms.Button
$objListBox = New-Object System.Windows.Forms.ListBox 
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
$handler_GoButton_Click=
{
   #MAIN BODY
   $i=1
   do {
   $date=Get-Date
   $filename = $PSScriptRoot+"\"+$objTextBox.Text+"-"+$date.Year+"-"+$date.Month+"-"+$date.Day+"_"+$date.Hour+"-"+$date.minute+"-"+$date.Second+".pcapng" 
    IF (($objTextBox.Text -ne "") -and ($objTextBoxMFS.Text -ne "") -and ($objTextBoxI.Text -ne ""))
    {
        wireshark -i $objListBox.SelectedItem  -k -w $filename
        Start-Sleep 7 
        $FirststartDate = Get-Date
        do {
            Start-Sleep 1
            #Change this to MB
            $objTextBoxM.Text=("Filesize is "+([math]::Round((Get-Item $filename).Length/1kb,2))+"KB")
            }
        until ((((Get-Item $filename).Length/1kb) -gt $objTextBoxMFS.Text) -or ((Get-Process | where {$_.Name -like "Wireshark"}) -eq $null) -or ( ((Get-Date) - $FirststartDate).minutes -gt $objTextBoxMFT.Text ))
        #Write Correct status in console
        IF ((Get-Process | where {$_.Name -like "Wireshark"}) -eq $null) 
            {
            $objTextBoxM.Text="Wireshark process exited."
            $i=$i+999999999
            }
        IF (((Get-Item $filename).Length/1kb) -gt $objTextBoxMFS.Text) {$objTextBoxM.Text=("Filesize limit of "+$objTextBoxMFS.Text+" reached, stopping capture"); Start-Sleep 2}
        IF ( ((Get-Date) - $FirststartDate).minutes -gt $objTextBoxMFT.Text  ) {$objTextBoxM.Text=("Wireshark was running for " + ((Get-Date) - $FirststartDate).minutes + " minutes")}

            $i++
            if ($i -le $objTextBoxI.Text) {$objTextBoxM.Text="Iteration $i started..."}
            #Kill all wireshark processes
            do {
            $ProcMonTestProcess = Get-Process | where {$_.ProcessName -eq "wireshark"}
            if ($ProcMonTestProcess){
            Stop-Process $ProcMonTestProcess.Id}
            }
            while ($ProcMonTestProcess.Id -eq $true)
            $basefilename=$objTextBox.Text
            
            #Cleanup old files
            dir $PSScriptRoot| where {$_.name -like "$basefilename*"} | % { if (-not ( (dir $PSScriptRoot | where {$_.name -like "$basefilename*"} | sort CreationTime | select -Last $objTextBoxFilesToKeep.Text Name) -match $_.name)) { Remove-Item ($PSScriptRoot+"\"+$_) -Force} }
        }
    ELSE
        {$objTextBoxM.Text="ERROR: Make sure there are no blank fields"}
    }
    UNTIL ($i -gt $objTextBoxI.Text)

}

$OnLoadForm_StateCorrection=
{   #Correct the initial state of the form to prevent the .Net maximized form issue
    $WSForm.WindowState = $InitialFormWindowState
    $objTextBoxM.ReadOnly=$true
    $objListBox.SelectedIndex=0
    $objTextBox.Text='WiresharkCapture'
}

$objTextBoxMFS_txtCHanged_handler=
{
   if ($objTextBoxMFS.Text -match '\D'){
        $objTextBoxMFS.Text = $objTextBoxMFS.Text -replace '\D' }
}

$objTextBoxMFT_txtCHanged_handler=
{
   if ($objTextBoxMFT.Text -match '\D'){
        $objTextBoxMFT.Text = $objTextBoxMFT.Text -replace '\D' }
}

$objTextBoxI_txtCHanged_handler=
{
   if ($objTextBoxI.Text -match '\D'){
        $objTextBoxI.Text = $objTextBoxI.Text -replace '\D' }
}

$objTextBoxFilesToKeep_txtCHanged_handler=
{
   if ($objTextBoxFilesToKeep.Text -match '\D'){
        $objTextBoxFilesToKeep.Text = $objTextBoxFilesToKeep.Text -replace '\D' }
}

#----------------------------------------------
#Main form
$WSForm.Text = "Wiresharker"
$WSForm.Name = "WSForm"
$WSForm.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 280
$System_Drawing_Size.Height = 345
$WSForm.ClientSize = $System_Drawing_Size

#GO button
$GoButton.TabIndex = 7
$GoButton.Name = "GoButton"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 262
$System_Drawing_Size.Height = 23
$GoButton.Size = $System_Drawing_Size
$GoButton.UseVisualStyleBackColor = $True
$GoButton.Text = "GO"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 275
$GoButton.Location = $System_Drawing_Point
$GoButton.DataBindings.DefaultDataSourceUpdateMode = 0
$GoButton.add_Click($handler_GoButton_Click)

#List box with interfaces
$objListBox = New-Object System.Windows.Forms.ListBox 
$objListBox.Location = New-Object System.Drawing.Size(10,30) 
$objListBox.Size = New-Object System.Drawing.Size(260,20) 
$objListBox.Height = 90
$objListBox.TabIndex = 0
Get-NetAdapter | % {[void] $objListBox.Items.Add($_.name)}

#Top label
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,15) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.Text = "Select NIC to capture on:"

#Label base file name
$objLabelFN = New-Object System.Windows.Forms.Label
$objLabelFN.Location = New-Object System.Drawing.Size(10,120) 
$objLabelFN.Size = New-Object System.Drawing.Size(280,15) 
$objLabelFN.Text = "Base filename:"

#Text Box base file name
$objTextBox = New-Object System.Windows.Forms.TextBox 
$objTextBox.Location = New-Object System.Drawing.Size(10,135) 
$objTextBox.Size = New-Object System.Drawing.Size(260,20) 
$objTextBox.TabIndex = 1

#Lebel max file time
$objLabelMFT = New-Object System.Windows.Forms.Label
$objLabelMFT.Location = New-Object System.Drawing.Size(10,165) 
$objLabelMFT.Size = New-Object System.Drawing.Size(150,20) 
$objLabelMFT.Text = "Max file time (minutes):"


#Text box max file time
$objTextBoxMFT = New-Object System.Windows.Forms.TextBox 
$objTextBoxMFT.Location = New-Object System.Drawing.Size(150,162.5) 
$objTextBoxMFT.Size = New-Object System.Drawing.Size(120,20) 
$objTextBoxMFT.add_TextChanged($objTextBoxMFT_txtCHanged_handler)
$objTextBoxMFT.TabIndex = 2

#Lebel max filesize
$objLabelMFS = New-Object System.Windows.Forms.Label
$objLabelMFS.Location = New-Object System.Drawing.Size(10,195) 
$objLabelMFS.Size = New-Object System.Drawing.Size(100,20) 
$objLabelMFS.Text = "Max file size (KB):"

#Text box max filesize
$objTextBoxMFS = New-Object System.Windows.Forms.TextBox 
$objTextBoxMFS.Location = New-Object System.Drawing.Size(150,191) 
$objTextBoxMFS.Size = New-Object System.Drawing.Size(120,20) 
$objTextBoxMFS.add_TextChanged($objTextBoxMFS_txtCHanged_handler)
$objTextBoxMFS.TabIndex = 3

#Lebel iterations
$objLabelI = New-Object System.Windows.Forms.Label
$objLabelI.Location = New-Object System.Drawing.Size(10,225) 
$objLabelI.Size = New-Object System.Drawing.Size(150,20) 
$objLabelI.Text = "Number of iterations:"

#Text box iterations
$objTextBoxI = New-Object System.Windows.Forms.TextBox 
$objTextBoxI.Location = New-Object System.Drawing.Size(150,220) 
$objTextBoxI.Size = New-Object System.Drawing.Size(120,20) 
$objTextBoxI.add_TextChanged($objTextBoxI_txtCHanged_handler)
$objTextBoxI.TabIndex = 4

#Lebel historical files
$objLabelFilesToKeep = New-Object System.Windows.Forms.Label
$objLabelFilesToKeep.Location = New-Object System.Drawing.Size(10,255) 
$objLabelFilesToKeep.Size = New-Object System.Drawing.Size(130,20) 
$objLabelFilesToKeep.Text = "Number of files to keep:"

#Text box historical files
$objTextBoxFilesToKeep = New-Object System.Windows.Forms.TextBox 
$objTextBoxFilesToKeep.Location = New-Object System.Drawing.Size(150,247.5) 
$objTextBoxFilesToKeep.Size = New-Object System.Drawing.Size(120,20) 
$objTextBoxFilesToKeep.add_TextChanged($objTextBoxFilesToKeep_txtCHanged_handler)
$objTextBoxFilesToKeep.TabIndex = 5

#Text box Messages
$objTextBoxM = New-Object System.Windows.Forms.TextBox 
$objTextBoxM.Location = New-Object System.Drawing.Size(10,305) 
$objTextBoxM.Size = New-Object System.Drawing.Size(260,20) 

$Icon = New-Object system.drawing.icon ("$PSScriptRoot\16px.ico")
$WSForm.Icon = $Icon 


$WSForm.Controls.Add($objListBox)
$WSForm.Controls.Add($GoButton)
$WSForm.Controls.Add($objLabel) 
$WSForm.Controls.Add($objLabelFN) 
$WSForm.Controls.Add($objLabelMFS) 
$WSForm.Controls.Add($objTextBox) 
$WSForm.Controls.Add($objTextBoxMFS) 
$WSForm.Controls.Add($objTextBoxMFT) 
$WSForm.Controls.Add($objTextBoxI) 
$WSForm.Controls.Add($objLabelMFT) 
$WSForm.Controls.Add($objTextBoxM) 
$WSForm.Controls.Add($objLabelI)
$WSForm.Controls.Add($objLabelFilesToKeep)
$WSForm.Controls.Add($objTextBoxFilesToKeep)


#Save the initial state of the form
$InitialFormWindowState = $WSForm.WindowState
$WSForm.FormBorderStyle = "FixedSingle"
$WSForm.MaximizeBox = $false;
#Init the OnLoad event to correct the initial state of the form
$WSForm.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$WSForm.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm 


