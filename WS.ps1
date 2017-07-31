#Generated Form Function
function GenerateForm {

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$HelpDeskForm = New-Object System.Windows.Forms.Form
$GoButton = New-Object System.Windows.Forms.Button
$objListBox = New-Object System.Windows.Forms.ListBox 
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$handler_GoButton_Click=
{
    #MAIN BODY
    $filename = "c:\temp\"+$objTextBox.Text
    #$filename | out-host
    wireshark -i $objListBox.SelectedItem  -k -w $filename
    do {
        Start-Sleep 5
        $objTextBoxM.Text=("Filesize is "+((Get-Item $filename).Length/1kb))
        }
    until (((Get-Item $filename).Length/1kb) -gt $objTextBoxMFS.Text)
    $objTextBoxM.Text=("Filesize limit of "+$objTextBoxMFS.Text+"reached, stopping capture")
        # Kill all wireshark processes
        do {
        Start-Sleep -seconds 2
        $ProcMonTestProcess = Get-Process | where {$_.ProcessName -eq "wireshark"}
        if ($ProcMonTestProcess){
        Stop-Process $ProcMonTestProcess.Id}
        }while(
        $ProcMonTestProcess.Id -eq $true
        )
        

}

$OnLoadForm_StateCorrection=
{   #Correct the initial state of the form to prevent the .Net maximized form issue
    $HelpDeskForm.WindowState = $InitialFormWindowState
    $objTextBoxM.ReadOnly=$true
    # Kill all wireshark processes
 <#   do{
    Start-Sleep -seconds 2
    $ProcMonTestProcess = Get-Process | where {$_.ProcessName -eq "wireshark"}
    if ($ProcMonTestProcess){
    Stop-Process $ProcMonTestProcess.Id}
    }while(
    $ProcMonTestProcess.Id -eq $true
    )
    # Kill all dumpcap.exe processes
    do{
    Start-Sleep -seconds 2
    $ProcMonTestProcess = Get-Process | where {$_.ProcessName -eq "dumpcap"}
    if ($ProcMonTestProcess){
    Stop-Process $ProcMonTestProcess.Id}
    }while(
    $ProcMonTestProcess.Id -eq $true
    )
    #>
}

#----------------------------------------------
#Main form
$HelpDeskForm.Text = "Wiresharker"
$HelpDeskForm.Name = "HelpDeskForm"
$HelpDeskForm.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 280
$System_Drawing_Size.Height = 255
$HelpDeskForm.ClientSize = $System_Drawing_Size

#GO button
$GoButton.TabIndex = 0
$GoButton.Name = "GoButton"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 262
$System_Drawing_Size.Height = 23
$GoButton.Size = $System_Drawing_Size
$GoButton.UseVisualStyleBackColor = $True
$GoButton.Text = "GO"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 9
$System_Drawing_Point.Y = 220
$GoButton.Location = $System_Drawing_Point
$GoButton.DataBindings.DefaultDataSourceUpdateMode = 0
$GoButton.add_Click($handler_GoButton_Click)

#List box with interfaces
$objListBox = New-Object System.Windows.Forms.ListBox 
$objListBox.Location = New-Object System.Drawing.Size(10,30) 
$objListBox.Size = New-Object System.Drawing.Size(260,20) 
$objListBox.Height = 90
Get-NetAdapter | % {[void] $objListBox.Items.Add($_.name)}

#Top label
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,10) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.Text = "Please select NIC to capture:"

#Filename label
$objLabelFN = New-Object System.Windows.Forms.Label
$objLabelFN.Location = New-Object System.Drawing.Size(10,115) 
$objLabelFN.Size = New-Object System.Drawing.Size(280,20) 
$objLabelFN.Text = "Base filename:"

#Text Box base file name
$objTextBox = New-Object System.Windows.Forms.TextBox 
$objTextBox.Location = New-Object System.Drawing.Size(10,135) 
$objTextBox.Size = New-Object System.Drawing.Size(260,20) 

#Lebel max file size
$objLabelMFS = New-Object System.Windows.Forms.Label
$objLabelMFS.Location = New-Object System.Drawing.Size(10,170) 
$objLabelMFS.Size = New-Object System.Drawing.Size(100,20) 
$objLabelMFS.Text = "Max file size (Mb):"

#Text box max filesize
$objTextBoxMFS = New-Object System.Windows.Forms.TextBox 
$objTextBoxMFS.Location = New-Object System.Drawing.Size(110,165) 
$objTextBoxMFS.Size = New-Object System.Drawing.Size(160,20) 

#Text box Messages
$objTextBoxM = New-Object System.Windows.Forms.TextBox 
$objTextBoxM.Location = New-Object System.Drawing.Size(10,195) 
$objTextBoxM.Size = New-Object System.Drawing.Size(260,20) 


$HelpDeskForm.Controls.Add($objListBox)
$HelpDeskForm.Controls.Add($GoButton)
$HelpDeskForm.Controls.Add($objLabel) 
$HelpDeskForm.Controls.Add($objLabelFN) 
$HelpDeskForm.Controls.Add($objLabelMFS) 
$HelpDeskForm.Controls.Add($objTextBox) 
$HelpDeskForm.Controls.Add($objTextBoxMFS) 
$HelpDeskForm.Controls.Add($objTextBoxM) 

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $HelpDeskForm.WindowState
#Init the OnLoad event to correct the initial state of the form
$HelpDeskForm.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$HelpDeskForm.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm 


