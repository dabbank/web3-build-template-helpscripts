function askToInstall
{
    $title = "Install Node and NPM Script"
    $message = "First copy 01_Install and 02_SetEnv to the folder you want node and npm to be installed. Continue?"
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Install Node"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Skip and copy first"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0)

    if($result){
     Write-Host "Quit"
        Exit
    }
}
askToInstall

$DevDownloadDirectory = [IO.Directory]::GetCurrentDirectory()

$clnt = New-Object System.Net.WebClient

# download and extract the file
$url = "http://nodejs.org/dist/v0.10.31/node.exe"
$fileLocation = "$DevDownloadDirectory\node.exe"
$clnt.DownloadFile($url,$fileLocation)

$url = "http://nodejs.org/dist/npm/npm-1.4.9.zip"
$fileLocation = "$DevDownloadDirectory\npm.zip"
$clnt.DownloadFile($url,$fileLocation)

$shell=new-object -com shell.application
$CurrentLocation=get-location
$CurrentPath=$CurrentLocation.path
$Location=$shell.namespace($CurrentPath)
$ZipFiles = get-childitem *.zip
$ZipFiles.count | out-default
foreach ($ZipFile in $ZipFiles)
{
    $ZipFile.fullname | out-default
    $ZipFolder = $shell.namespace($ZipFile.fullname)
    $Location.Copyhere($ZipFolder.items())
}

# Delete .zip npm file
Remove-Item $fileLocation