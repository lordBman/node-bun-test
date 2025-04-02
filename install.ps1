Write-Host "installing required packages"

#ensure autocannon is install, which will be used to test the servers of the NodeJS and Bun
npm install -g autocannon

#navigate into the node-test subfolder
Set-Location .\node-test

#install required packages for Node to run
npm install

#navigate into the bun-test subfolder
Set-Location ..\bun-test

#install required packages for Bun to run
bun install

Write-Host "required packages installation successful"

Set-Location ..\

Write-Host "checking if test folder and file exists"
#ensure the folder which will contain the test files exist, if create it.
$folder = ".\test-files"
if (!(Test-Path $folder)) { 
    New-Item -Path $folder -ItemType Directory 

    #create the test files
    1..10000 | ForEach-Object {
        New-Item -Path "$folder\file-$_.txt" -ItemType File
    }
}

Write-Host "done"
