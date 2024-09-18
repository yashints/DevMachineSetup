# Dev Machine Setup

This repository contains my current configuration for setting up a new PC for development purposes.

## Pre-reqs

You will need to enable the `winget` configuration by running:

```bash
winget configure --enable
```

## Steps

You need to clone the repo, open an administrator terminal and run the `SystemSetup.ps1`. Then simply follow any required interaction.

## List of things that will happen

### Windows Settings

* PC Name asked and Set
* Install WSL
* Install Virtual Machine Platform
* Enable Developer Mode
* Installing a WSL distro and move to D drive

### Installed Software

* Internet Download Manager
* Google Chrome
* Git for Windows
  * Setting git user name and email
* Oh My Posh
* GitHub CLI
* Azure Functions Core Tools
* Dev Home
* NodeJS
* FNM
* Yarn
* Python
* DotNet SDK
* Power Toys
* Docker Desktop
* VS Code
* VS Code Insiders
  * Install extensions
* PowerShell
* GSudo (used in Windows Terminal to get admin shell)
* Azure CLI
* Bicep CLI
* VS Enterprise 2022
* Nerd Fonts
* Terminal Icons
* Key Base
* Gpg4Win
* ZoomIt
* DevToys

### Removed Software

These software will be removed:

* Microsoft.BingFinance
* Microsoft.BingNews
* Microsoft.BingSports
* Microsoft.BingWeather
* Microsoft.FreshPaint
* Microsoft.Getstarted
* Microsoft.Microsoft3DViewer
* Microsoft.MicrosoftOfficeHub
* Microsoft.MicrosoftSolitaireCollection
* Microsoft.WindowsFeedbackHub
* Microsoft.SkypeApp
* Microsoft.WindowsAlarms
* Microsoft.WindowsMaps
* Microsoft.ZuneVideo
* Microsoft.MinecraftUWP
* Microsoft.MicrosoftPowerBIForWindows
* Microsoft.NetworkSpeedTest
* Microsoft.ConnectivityStore
* Microsoft.Messaging
* Microsoft.Office.Sway
* Microsoft.OneConnect
* Microsoft.BingFoodAndDrink
* Microsoft.BingTravel
* Microsoft.BingHealthAndFitness
* Microsoft.WindowsReadingList
* 9E2F88E3.Twitter
* PandoraMediaInc.29680B314EFC2
* Flipboard.Flipboard
* ShazamEntertainmentLtd.Shazam
* king.com.CandyCrushSaga
* king.com.CandyCrushSodaSaga
* king.com.*
* ClearChannelRadioDigital.iHeartRadio
* 4DF9E0F8.Netflix
* 6Wunderkinder.Wunderlist
* Drawboard.DrawboardPDF
* 2FE3CB00.PicsArt-PhotoStudio
* D52A8D61.FarmVille2CountryEscape
* TuneIn.TuneInRadio
* GAMELOFTSA.Asphalt8Airborne
* TheNewYorkTimes.NYTCrossword
* DB6EA5DB.CyberLinkMediaSuiteEssentials
* Facebook.Facebook
* flaregamesGmbH.RoyalRevolt2
* Playtika.CaesarsSlotsFreeCasino
* A278AB0D.MarchofEmpires
* KeeperSecurityInc.Keeper
* ThumbmunkeysLtd.PhototasticCollage
* XINGAG.XING
* 89006A2E.AutodeskSketchBook
* D5EA27B7.Duolingo-LearnLanguagesforFree
* 46928bounde.EclipseManager
* ActiproSoftwareLLC.562882FEEB491
* DolbyLaboratories.DolbyAccess
* SpotifyAB.SpotifyMusic
* A278AB0D.DisneyMagicKingdoms
* WinZipComputing.WinZipUniversal
* BethesdaSoftworks.FalloutShelter
* PandoraMediaInc.29680B314EFC2
* AdobeSystemIncorporated.AdobePhotoshop
* Microsoft.Print3D
* king.com.BubbleWitch3Sag

### Other Settings

* Windows terminal settings
* PowerShell profile

### Clean up

After all that the temp folder will be deleted and temporary files be removed.
