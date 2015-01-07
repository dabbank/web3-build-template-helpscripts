echo ""

git version
echo ""

# GIT
$proxy = "!!!!!!!!!INSERT HERE!!!!!!!!!!!"



[Environment]::SetEnvironmentVariable("HTTP_PROXY", $proxy, "User")
[Environment]::SetEnvironmentVariable("HTTPS_PROXY", $proxy, "User")
git config --global http.proxy $proxy
git config --global https.proxy $proxy
git config --global url."https://".insteadOf git://

echo "Git proxy and http protocol switch is set successful"
echo $env:Path

if($env:NODE_HOME){
    echo "" "NODE_HOME already set to " $env:NODE_HOME ""
}
if($env:Path.Contains("node")){
    echo "Node is already in path"  ""
    echo $env:Path
}

echo ""

function askToQuit
{
    $title = "SetEnv Script"
    $message = "Continue to set environment variables for local Node & npm 01_Install?"
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Set environments"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "close script"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0)

    if($result){
     Write-Host "Quit"
        Exit
    }
}
askToQuit

$CurrentLocation=get-location
$CurrentPath=$CurrentLocation.path

[Environment]::SetEnvironmentVariable("NODE_HOME", $CurrentPath, "User")
[Environment]::SetEnvironmentVariable("NPM_BIN_HOME", $CurrentPath +"\node_modules\.bin", "User")
# for npm and stuff
if(!$env:Path.Contains("node") -or !$env:Path.Contains("npm") ){
echo "Setting PATH variables..."

$path1 = $env:Path+";"+ $env:NPM_BIN_HOME+";"+$env:NODE_HOME
[Environment]::SetEnvironmentVariable("PATH", $path1, "User")

}

echo $env:Path

echo ""
echo "Successful set installed environment variables"
