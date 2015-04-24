# required parameters :
#       $buildNumber

Framework "4.0"

properties {
    # build properties - change as needed
    $baseDir = resolve-path .\
    $sourceDir = "$baseDir"
    $outDir = "$baseDir\buildartifacts"

	if (-not ($outDir.EndsWith("\"))) { 
      $outDir += '\' #MSBuild requires OutDir end with a trailing slash #awesome
	  } 
  
    if ($outDir.Contains(" ")) { 
      $outDir="""$($outDir)\""" 
	  }

	$projectName = "HelloCI"
    $projectConfig = "Release"
	$webSite = "$baseDir\buildartifacts\_PublishedWebsites\HelloCI.Web"
	$ProcessIIS = "iisexpress"

    # tools
    # change testExecutable as needed, defaults to mstest
    $testExecutable = "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\mstest.exe"
    $nuget = "$sourceDir\packages\NuGet.CommandLine.2.5.0\tools\NuGet.exe"
	}
 

task default -depends Compile

# Delete any existing buildartifact folder
task Clean {
    Write-Host "Deleting the buildartifacts directory"
    DeleteDirectory $outDir
}

#  Initialize the build
task Init -depends Clean {
    Write-Host "Creating the buildartifacts directory"
    CreateDirectory $outDir
}

# Compile the Project solution and any other solutions necessary
task Compile -depends Init {
    Write-Host "Building the solution"
    exec { msbuild /t:build /v:q /nologo /p:Configuration=$projectConfig /p:OutDir=$outdir $sourceDir\$projectName.sln }
}

# Start Website
task StartWebsite -depends StopWebsite, Compile {
    $iisexpress = "$env:ProgramFiles\IIS Express\iisexpress.exe"
    start $iisexpress @("/port:9999 /path:$webSite")  
}

# Stop Website
task StopWebsite {
    $ProcessIsRunning = Get-Process $ProcessIIS -ErrorAction SilentlyContinue
	if ($ProcessIsRunning) {
       exec { taskkill  /F /IM ($ProcessIIS + ".exe") }
	}
}

# Execute unit tests
# Change as necessary if using a different test tool
task UnitTest -depends Compile {
    exec { & $testExecutable /testcontainer:$unitTestAssembly | Out-Null }
}

# Package the project web code
# Copy only the necessary files, exclude .cs files
task PackageProject -depends Compile {
    Write-Host "Packaging $projectName"
    CopyWebSiteFiles $projectSourceDir "$projectPackageDir\content\"

    # deploy.ps1 is used by Octopus Deploy
    Write-Host "Copying $projectDeployFile to $projectPackageDir\Deploy.ps1"
    cp $projectDeployFile "$projectPackageDir\Deploy.ps1"
    
    attrib -r "$projectPackageDir\*.*" /S /D
}

# The Package task depends on all other package tasks
# Template only includes one package task (PackageProject).
# If you need to package multiple solutions, add them as dependencies for Package
task Package -depends PackageProject { #, PackageApiProject, PackageDatabase {
}

# Deploy the project locally
task DeployProject -depends PackageProject {
    cd $projectPackageDir
    & ".\Deploy.ps1"
    cd $baseDir
}

# ------------------------------------------------------------------------------------#
# Utility methods
# ------------------------------------------------------------------------------------#

# Copy files needed for a website, ignore source files and other unneeded files
function global:CopyWebSiteFiles($source, $destination){
    $exclude = @('*.user', '*.dtd', '*.tt', '*.cs', '*.csproj', '*.orig', '*.log')
    CopyFiles $source $destination $exclude
    DeleteDirectory "$destination\obj"
}

# copy files to a destination
# create the directory if it does not exist
function global:CopyFiles($source, $destination, $exclude = @()){    
    CreateDirectory $destination
    Get-ChildItem $source -Recurse -Exclude $exclude | Copy-Item -Destination { Join-Path $destination $_.FullName.Substring($source.length); }
}

# Create a directory
function global:CreateDirectory($directoryName)
{
    mkdir $directoryName -ErrorAction SilentlyContinue | Out-Null
}

# Delete a directory
function global:DeleteDirectory($directory_name)
{
    rd $directory_name -recurse -force -ErrorAction SilentlyContinue | Out-Null
}

# Delete a file if it exists
function global:DeleteFile($file) {
    if ($file)
    {
        Remove-Item $file -force -recurse -ErrorAction SilentlyContinue | Out-Null
    }
}