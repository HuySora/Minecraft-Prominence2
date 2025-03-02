param (
   [switch]$Silent = $false
)

# Check if the script is running with elevated privileges
if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    # Get the absolute path of the script
    $absolutePath = Resolve-Path $MyInvocation.MyCommand.Path

    # Prepare the arguments to pass, including the script path
    $args = @("-File `"$absolutePath`"")

    # Add bound parameters to the argument list
    if ($Silent) {
        $args += "-Silent"
    }

    # Start a new PowerShell process with elevated privileges and pass the arguments
    Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $args
    Exit
}
# Push location to the current script directory
Push-Location $PSScriptRoot

# Source directory and target link directory for each folder
$folders = @{
    "config" = @{
        "source" = "..\config"
        "ignoreNames" = @() # Add file or folder names to ignore
    }
    "defaultconfigs" = @{
        "source" = "..\defaultconfigs"
        "ignoreNames" = @()
    }
<# Fabric server installer can't detect symbolic
    "libraries" = @{
        "source" = "..\..\libraries"
        "target" = "libraries"
        "ignoreNames" = @()
        "link" = $true
    }
#>
    "mods" = @{
        "source" = "..\mods"
        "ignoreNames" = @(
            "ae2-emi-crafting-1.3.1.jar",
            "AE2-MouseTweaks-Fix-2.0.0+1.20.1+fabric.jar",
            "AmbientSounds_FABRIC_v5.3.5_mc1.20.1.jar",
            "amecs-1.3.10+mc.1.20.1.jar",
            "Animation_Overhaul-fabric-1.20.x-1.3.1.jar",
            "asteorbar-fabric-1.20.1-1.4.6.jar",
            "auudio_fabric_1.0.3_MC_1.20.jar",
            "axolotl-item-fix-1.1.7.jar",
            "BadOptimizations-2.1.4-1.20.1.jar",
            "BetterAdvancements-Fabric-1.20.1-0.3.2.161.jar",
            "betterbeds-1.3.0-1.19.3.jar",
            "BHMenu-Fabric-1.20.1-2.4.1.jar",
            "blur-3.1.0.jar",
            "Boat-Item-View-Fabric-1.20.1-0.0.5.jar",
            "bobby-5.0.1.jar",
            "cat_jam-fabric-mc1.20-1.2.1.jar",
            "chat_heads-0.10.26-fabric-1.20.jar",
            "chatanimation-1.0.5.jar",
            "cherishedworlds-fabric-6.1.3+1.20.1.jar",
            "CITResewn-1.1.3+1.20.jar",
            "clickadv-fabric-1.20.1-3.6.jar",
            "DisableCustomWorldsAdvice-4.1.jar",
            "distraction_free_recipes-fabric-1.0.0-1.20.1.jar",
            "drippyloadingscreen_fabric_3.0.8_MC_1.20.1.jar",
            "eating-animation-1.20+1.9.5-CMDfix.jar",
            "EMI Create Schematics [1.0.1 Fabric 1.20.1].jar",
            "emiffect-fabric-1.1.2+mc1.20.1.jar",
            "emitrades-fabric-1.2.1+mc1.20.1.jar",
            "entity_model_features_fabric_1.20.1-2.1.3.jar",
            "entity_texture_features_fabric_1.20.1-6.1.3.jar",
            "entityculling-fabric-1.6.2-mc1.20.1.jar",
            "EuphoriaPatcher-1.4.3-r5.3-fabric.jar",
            "fallingleaves-1.15.4+1.20.1.jar",
            "fancymenu_fabric_3.3.2_MC_1.20.1.jar",
            "fast-ip-ping-mc1.20.4-fabric-v1.0.1.jar",
            "ftbquestsfreezefix-fabric-1.0.0-1.20.1.jar",
            "GeckoLibIrisCompat-Fabric-1.0.0.jar",
            "gpumemleakfix-fabric-1.20.1-1.8.jar",
            "Highlighter-1.20.1-fabric-1.1.6.jar",
            "ImmediatelyFast-Fabric-1.2.17+1.20.4.jar",
            "indium-1.0.34+mc1.20.1.jar",
            "iris-1.7.2+mc1.20.1.jar",
            "iris-flywheel-compat-fabric1.20.1+1.1.2.jar",
            "ItemBorders-1.20.1-fabric-1.2.2.jar",
            "ItemLocks-Fabric-1.20.1-1.3.6.jar",
            "language-reload-1.5.10+1.20.1.jar",
            "lazy-language-loader-0.3.3.jar",
            "leawind_third_person-v2.2.0-mc1.20-1.20.1-fabric.jar",
            "LegendaryTooltips-1.20.1-fabric-1.4.4.jar",
            "loadmyresources_fabric_1.0.4-1_MC_1.20.jar",
            "lootbeams-1.0.3.jar",
            "MindfulDarkness-v8.0.2-1.20.1-Fabric.jar",
            "MouseTweaks-fabric-mc1.20-2.25.jar",
            "nicer-skies-1.3.0+1.20.1.jar",
            "no-report-button-fabric-1.5.0.jar",
            "notenoughanimations-fabric-1.6.4-mc1.20.jar",
            "PickUpNotifier-v8.0.0-1.20.1-Fabric.jar",
            "PresenceFootsteps-1.9.4+1.20.1.jar",
            "Prism-1.20.1-fabric-1.0.5.jar",
            "reeses_sodium_options-1.7.2+mc1.20.1-build.101.jar",
            "ResourcePackOverrides-v8.0.2-1.20.1-Fabric.jar",
            "Searchables-fabric-1.20.1-1.0.2.jar",
            "seasonhud-fabric-1.20.1-1.6.1.jar",
            "SimpleDiscordRichPresence-fabric-4.0.3-build.40+mc1.20.1.jar",
            "sodiumdynamiclights-fabric-1.0.8-1.20.1.jar",
            "sodium-extra-0.5.4+mc1.20.1-build.115.jar",
            "sodium-fabric-0.5.11+mc1.20.1.jar",
            "sorted_enchantments-1.0.1+1.19.3+fabric.jar",
            "TravelersTitles-1.20-Fabric-4.0.2.jar",
            "visuality-0.7.1+1.20.jar",
            "welcomescreen-fabric-1.0.0-1.20.1.jar",
            "YeetusExperimentus-Fabric-2.3.1-build.6+mc1.20.1.jar",
            "Zoomify-2.11.2.jar"
        )
    }
<# Fabric server installer can't detect symbolic
    "versions" = @{
        "source" = "..\..\versions"
        "target" = "versions"
        "ignoreNames" = @()
        "link" = $true
    }
#>
    "schematics" = @{
        "source" = "..\schematics"
        "ignoreNames" = @()
    }
}

# Function to copy files from source to target directory
function Copy-Files {
    param(
        [string]$sourceDirectory,
        [string]$targetDirectory,
        [string[]]$ignoreNames
    )

    # Get files and folders in the source directory
    $items = Get-ChildItem -Path $sourceDirectory

    # Loop through each item and copy it to the target directory
    foreach ($item in $items) {
        # Check if item is not in the ignore list
        if ($ignoreNames -notcontains $item.Name) {
            # Check if item is a directory or file
            if ($item.PSIsContainer) {
                # Copy directory to target directory
                Write-Host "Copying directory: Copy-Item -Path `"$($item.FullName)`" -Destination `"$targetDirectory\$($item.Name)`" -Recurse -Force"
                $src = [Management.Automation.WildcardPattern]::Escape($item.FullName)
                $dest = [Management.Automation.WildcardPattern]::Escape("$targetDirectory\$($item.Name)")
                Copy-Item -Path $src -Destination $dest -Recurse -Force
            } else {
                # Copy file to target directory
                Write-Host "Copying file: Copy-Item -Path `"$($item.FullName)`" -Destination `"$targetDirectory`" -Force"
                $src = [Management.Automation.WildcardPattern]::Escape($item.FullName)
                $dest = [Management.Automation.WildcardPattern]::Escape($targetDirectory)
                Copy-Item -Path $src -Destination $dest -Force
            }
        }
    }
}

# Loop through each folder and create symbolic links or copy files
foreach ($folderName in $folders.Keys) {
    $folder = $folders[$folderName]
    $sourceDirectory = $folder["source"]
    $targetDirectory = $folderName
    $ignoreNames = $folder["ignoreNames"]

    # Remove previous symbolic link and folder if they exist
    if (Test-Path -Path $targetDirectory) {
        Write-Host "Removing previous symbolic link and folder: rmdir `"$targetDirectory`" /s /q"
        git rm --cached -r "$targetDirectory"
        # Check if item is a directory or file
        if (Test-Path -Path $targetDirectory -PathType Container) {
            cmd /c rmdir "$targetDirectory" /s /q
        } else {
            cmd /c del "$targetDirectory" /q
        }
    }

    # Check if symbolic link should be created
    if ($folder["link"]) {
        # Create symbolic link for directory
        Write-Host "Creating symbolic link for folder: mklink /D `"$targetDirectory`" `"$sourceDirectory`""
        cmd /c mklink /D "$targetDirectory" "$sourceDirectory"
        git reset HEAD -- "$targetDirectory"
    } else {
        # Create new target directory
        Write-Host "Creating target directory: New-Item -Path `"$targetDirectory`" -ItemType Directory"
        New-Item -Path $targetDirectory -ItemType Directory | Out-Null
        # Copy files from source to target directory
        Write-Host "Copying files to target directory..."
        Copy-Files -sourceDirectory $sourceDirectory -targetDirectory $targetDirectory -ignoreNames $ignoreNames
    }
}

# Pop back to the previous location
Pop-Location

# Conditionally pause based on -Silent argument
if (-not $Silent) {
    cmd /c pause
}