$WarningPreference = "SilentlyContinue"
$ErrorActionPreference = "Continue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy Unrestricted -Force
Install-PSResource -Name PSReadLine -Prerelease

#####################################################################################################################################################################################################
#                                                   PRE-REQUISITES
#####################################################################################################################################################################################################
Clear-Host
Write-Host "Please Enter Your Desired Computer Name: "  -ForegroundColor Cyan 
$ComputerName = Read-Host 
Rename-Computer -NewName $ComputerName | Out-Null

#####################################################################################################################################################################################################
#                                                   Windows Setup
#####################################################################################################################################################################################################
Clear-Host
Write-Host "Configuring Windows Settings" -ForegroundColor Green

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /Add-Capability /CapabilityName:Tools.DeveloperMode.Core~~~~0.0.1.0

# Install WSL
Write-Host "Installing Install WSL" -ForegroundColor Magenta 

wsl --set-default-version 2

$distributions = wsl -l -o
$distros = $distributions | Select-Object -Skip 7 | Where-Object { $_.Trim() -ne "" }
$distroList = $distros -replace '\s{2,}', ' ' | ForEach-Object { ($_ -split ' ')[0] }

$index = 1
$distroList | ForEach-Object {
    Write-Host "$index. $_"
    $index++
}

$choice = Read-Host "Please select a distro to install (enter number)"
$selectedDistro = $distroList[$choice - 1]

$validChoice = $false
while (-not $validChoice) {
    $choice = Read-Host "Please select a distro to install (enter number)"
    
    # Check if the input is a valid number and within range
    if ([int]::TryParse($choice, [ref]$null) -and $choice -ge 1 -and $choice -le $distroList.Count) {
        $validChoice = $true
        $selectedDistro = $distroList[$choice - 1]
        Write-Host "You chose $selectedDistro, let's get it installed" -ForegroundColor Magenta 
        wsl --install -d $selectedDistro
    } else {
        Write-Host "Invalid selection. Please enter a number between 1 and $($distroList.Count)." -ForegroundColor Red
    }
}


Write-Host "Moving WSL installation to another drive" -ForegroundColor Magenta 

$currentDir = Get-Location

winget configure -f ./SystemConfig/ModifyWindowsSettings.yaml

mkdir d:\WSL

cd d:\WSL

mkdir .\$selectedDistro

wsl --export $selectedDistro $selectedDistro.tar

wsl --unregister $selectedDistro

wsl --import $selectedDistro ./$selectedDistro $selectedDistro.tar

cd $currentDir
#####################################################################################################################################################################################################
#                                                   Install Dev Tools
#####################################################################################################################################################################################################
Clear-Host

Write-Host "Installing Internet Download Manager" -ForegroundColor Green

winget install --id=Tonec.InternetDownloadManager  -e

Write-Host "    Google Chrome" -ForegroundColor Magenta
winget install --id=Google.Chrome  -e

Write-Host "Installing Git" -ForegroundColor Green

winget install --id=Git.Git  -e

Update-SessionEnvironment

$choice = Read-Host "Enter your git full name:"
git config --global user.name = $choice
$choice = Read-Host "Enter your git email address:"
git config --global user.email $choice
git config --global core.editor code -w
git config --global init.defaultBranch main

Clear-Host
Write-Host "Installing Oh My Posh" -ForegroundColor Green

winget install --id=JanDeDobbeleer.OhMyPosh  -e

Write-Host "Installing GitHub CLI" -ForegroundColor Green

winget install --id=GitHub.cli  --source winget

Write-Host "Installing Azure Function Core Tools" -ForegroundColor Green

winget install --id=Microsoft.Azure.FunctionsCoreTools -e  --source winget

Write-Host "Installing Dev Home" -ForegroundColor Green

winget install --id=Microsoft.DevHome  --source winget

Write-Host "Installing NodeJs" -ForegroundColor Green

winget install --id=OpenJS.NodeJS  -e
winget install --id=Yarn.Yarn -e
winget install --id=Schniz.fnm  -e

Write-Host "Installing Python" -ForegroundColor Green

winget install --id=Python.Python.3.9  -e

Write-Host "Installing DotNet" -ForegroundColor Green

winget install --id=Microsoft.DotNet.SDK.8 -e

Write-Host "Installing PowerToys" -ForegroundColor Green 

winget install --id=Microsoft.PowerToys  -e

# Docker Desktop
Write-Host "Installing Docker Desktop" -ForegroundColor Green 

winget install --id=Docker.DockerDesktop  -e

Write-Host "Installing VS Code, Insiders and their extensions" -ForegroundColor Green 

winget install --id=Microsoft.VisualStudioCode  -e
winget install Microsoft.VisualStudioCode.Insiders -e
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension esbenp.prettier-vscode --force
code --install-extension aaron-bond.better-comments --force
code --install-extension formulahendry.auto-rename-tag --force
code --install-extension naumovs.color-highlight --force
code --install-extension anteprimorac.html-end-tag-labels --force
code --install-extension github.vscode-pull-request-github --force
code --install-extension eamodio.gitlens-insiders --force
code --install-extension ms-dotnettools.csharp --force
code --install-extension visualstudioexptteam.vscodeintellicode --force
code --install-extension ms-playwright.playwright --force
code --install-extension yzhang.markdown-all-in-one --force
code --install-extension davidanson.vscode-markdownlint --force
code --install-extension rangav.vscode-thunder-client --force
code --install-extension github.copilot --force
code --install-extension dzhavat.bracket-pair-toggler --force
code --install-extension ms-vscode.vscode-node-azure-pack --force
code --install-extension ms-azure-devops.azure-pipelines --force
code --install-extension GitHub.vscode-github-actions --force
code --install-extension ms-vscode-remote.remote-wsl --force
code --install-extension ms-dotnettools.csdevkit --force
code --install-extension ms-vscode.PowerShell --force

code-insiders --install-extension dbaeumer.vscode-eslint --force
code-insiders --install-extension esbenp.prettier-vscode --force
code-insiders --install-extension aaron-bond.better-comments --force
code-insiders --install-extension formulahendry.auto-rename-tag --force
code-insiders --install-extension naumovs.color-highlight --force
code-insiders --install-extension anteprimorac.html-end-tag-labels --force
code-insiders --install-extension github.vscode-pull-request-github --force
code-insiders --install-extension eamodio.gitlens-insiders --force
code-insiders --install-extension ms-dotnettools.csharp --force
code-insiders --install-extension visualstudioexptteam.vscodeintellicode --force
code-insiders --install-extension ms-playwright.playwright --force
code-insiders --install-extension yzhang.markdown-all-in-one --force
code-insiders --install-extension davidanson.vscode-markdownlint --force
code-insiders --install-extension rangav.vscode-thunder-client --force
code-insiders --install-extension github.copilot --force
code-insiders --install-extension dzhavat.bracket-pair-toggler --force
code-insiders --install-extension ms-vscode.vscode-node-azure-pack --force
code-insiders --install-extension ms-azure-devops.azure-pipelines --force
code-insiders --install-extension GitHub.vscode-github-actions --force
code-insiders --install-extension ms-vscode-remote.remote-wsl --force
code-insiders --install-extension ms-dotnettools.csdevkit --force
code-insiders --install-extension ms-vscode.PowerShell --force

Write-Host "Installing PowerShell" -ForegroundColor Green 

winget install --id=Microsoft.PowerShell  --source winget

Write-Host "Installing GSudo" -ForegroundColor Green 

winget install --id=gerardog.gsudo  -e

Write-Host "Installing Azure CLI" -ForegroundColor Green 

winget install --id=Microsoft.AzureCLI  --source winget

Write-Host "Installing Azure Bicep" -ForegroundColor Green 

winget install --id=Microsoft.Bicep  -e

Write-Host "Installing VS 2022" -ForegroundColor Green 

winget install --id=Microsoft.VisualStudio.2022.Enterprise  --source winget

# Install fonts
Write-Host "Installing Nerd Fonts" -ForegroundColor Green 

& ([scriptblock]::Create((iwr 'https://to.loredo.me/Install-NerdFont.ps1'))) 10,11,12,13,14,15,16,17,28,29

# Install terminal icons
Write-Host "Installing Terminal Icons" -ForegroundColor Green 
Install-Module -Name Terminal-Icons -Repository PSGallery

Import-Module -Name Terminal-Icons

#Tools

Write-Host "Installing Key base" -ForegroundColor Magenta

winget install --id=Keybase.Keybase  -e

Write-Host "Installing GPG4Win" -ForegroundColor Magenta
winget install --id=GnuPG.Gpg4win  -e

Write-Host "Installing ZoomIt" -ForegroundColor Magenta
winget install --id=Microsoft.Sysinternals.ZoomIt  -e

Write-Host "Installing DevToys" -ForegroundColor Magenta
winget install --id=DevToys-app.DevToys  -e

#####################################################################################################################################################################################################
#                                                   REMOVING PREINSTALLED APPS
#####################################################################################################################################################################################################
Write-Host "Removing Preinstalled Windows Apps" -ForegroundColor Green

$ApplicationList = "Microsoft.BingFinance",
"Microsoft.BingNews",
"Microsoft.BingSports",
"Microsoft.BingWeather",
"Microsoft.FreshPaint",
"Microsoft.Getstarted",
"Microsoft.Microsoft3DViewer",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.WindowsFeedbackHub",
"Microsoft.SkypeApp",
"Microsoft.WindowsAlarms",
"Microsoft.WindowsMaps",
"Microsoft.ZuneVideo",
"Microsoft.MinecraftUWP",
"Microsoft.MicrosoftPowerBIForWindows",
"Microsoft.NetworkSpeedTest",
"Microsoft.ConnectivityStore",
"Microsoft.Messaging",
"Microsoft.Office.Sway",
"Microsoft.OneConnect",
"Microsoft.BingFoodAndDrink",
"Microsoft.BingTravel",
"Microsoft.BingHealthAndFitness",
"Microsoft.WindowsReadingList",
"9E2F88E3.Twitter",
"PandoraMediaInc.29680B314EFC2",
"Flipboard.Flipboard",
"ShazamEntertainmentLtd.Shazam",
"king.com.CandyCrushSaga",
"king.com.CandyCrushSodaSaga",
"king.com.*",
"ClearChannelRadioDigital.iHeartRadio",
"4DF9E0F8.Netflix",
"6Wunderkinder.Wunderlist",
"Drawboard.DrawboardPDF",
"2FE3CB00.PicsArt-PhotoStudio",
"D52A8D61.FarmVille2CountryEscape",
"TuneIn.TuneInRadio",
"GAMELOFTSA.Asphalt8Airborne",
"TheNewYorkTimes.NYTCrossword",
"DB6EA5DB.CyberLinkMediaSuiteEssentials",
"Facebook.Facebook",
"flaregamesGmbH.RoyalRevolt2",
"Playtika.CaesarsSlotsFreeCasino",
"A278AB0D.MarchofEmpires",
"KeeperSecurityInc.Keeper",
"ThumbmunkeysLtd.PhototasticCollage",
"XINGAG.XING",
"89006A2E.AutodeskSketchBook",
"D5EA27B7.Duolingo-LearnLanguagesforFree",
"46928bounde.EclipseManager",
"ActiproSoftwareLLC.562882FEEB491",
"DolbyLaboratories.DolbyAccess",
"SpotifyAB.SpotifyMusic",
"A278AB0D.DisneyMagicKingdoms",
"WinZipComputing.WinZipUniversal",
"BethesdaSoftworks.FalloutShelter",
"PandoraMediaInc.29680B314EFC2",
"AdobeSystemIncorporated.AdobePhotoshop",
"Microsoft.Print3D",
"king.com.BubbleWitch3Saga"

ForEach ($CurrentAppName in $ApplicationList) {

    Write-Host "    Removing $CurrentAppName" -ForegroundColor Magenta
    
    $PackageFullName = (Get-AppxPackage $CurrentAppName).PackageFullName
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.Displayname -eq $CurrentAppName}).PackageName

    if ($PackageFullName) {
        Remove-AppxPackage -Package $PackageFullName | Out-Null
    }

    if ($ProPackageFullName) {        
        Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName | Out-Null
    }
}

#####################################################################################################################################################################################################
#                                                   Copy Terminal Settings and PowerShell Profile
#####################################################################################################################################################################################################

copy ./WindowsTerminal/settings.json $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force
$docsfolder = [environment]::getfolderpath("mydocuments")
Copy-Item "./PowerShell/Microsoft.PowerShell_profile.ps1" -Destination "$docsfolder\PowerShell\Microsoft.PowerShell_profile.ps1" -Force

#####################################################################################################################################################################################################
#                                                   CLEAN UP
#####################################################################################################################################################################################################

Write-Host "Cleaning Up..." -ForegroundColor Green

Write-Host "    Temp Folders" -ForegroundColor Magenta
$Tempfolders = @("C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\Temp\*", "C:\Users\*\Appdata\Local\Temp\*")
Remove-Item $Tempfolders -Force -Recurse -ErrorAction SilentlyContinue | Out-Null

Write-Host "    Scheduling Cleanup Of WinSXS Folder on Next Startup" -ForegroundColor Magenta
New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "Cleanup WinSXS" -Value "Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase" | Out-Null 