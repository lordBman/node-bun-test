Write-Host "NodeJS Stsrtup time tests"
1..5 | ForEach-Object {
    Write-Host "Run $_: $( (Measure-Command { node -e "console.log('Hello')" }).TotalSeconds ) seconds"
}

Write-Host "\nBun Stsrtup time tests"
1..5 | ForEach-Object {
    Write-Host "Run $_: $( (Measure-Command { bun -e "console.log('Hello')" }).TotalSeconds ) seconds"
}

#ensure the folder which will contain the test files exist, if create it.
$folder = ".\test-files"
if (!(Test-Path $folder)) { New-Item -Path $folder -ItemType Directory }
#create the test files
1..1000 | ForEach-Object {
    New-Item -Path "$folder\file-$_.txt" -ItemType File
}

#ensure autocannon is install, which will be used to test the servers of the NodeJS and Bun
npm install -g autocannon


#navigate into the node-test subfolder
cd .\node-test

#Benchmark NodeJS server
Write-Host "\nNodeJS server tests"
node index.js &  # Run server in background
autocannon http://localhost:3000/users/nobel -d 10 -c 100  # 10 sec, 100 concurrent connections
pkill -f "node server-node.js"  # Kill Node server

Write-Host "\nNodeJS server with Express tests"
node run express-server.js &  # Run express server with NodeJS
autocannon http://localhost:3000/users/nobel -d 10 -c 100
pkill -f "node run express-server.js"

#Benchmark NodeJS files
Write-Host "\nNodeJS files tests"
node run node-files.js

#Benchmark NodeJS sqlite
Write-Host "\nNodeJS sqlite tests"
node run node-sqlite.ts


#navigate into the bun-test subfolder
cd ..\bun-test

#Benchmark Bun server
Write-Host "\nBun server tests"
bun run index.ts &  # Run Bun server
autocannon http://localhost:3000 -d 10 -c 100
pkill -f "bun run index.ts"

Write-Host "\nBun server with Express tests"
bun run express-server.ts &  # Run express server with Bun
autocannon http://localhost:3000 -d 10 -c 100
pkill -f "bun run express-server.ts"

Write-Host "\nBun server with Elysia tests"
bun run elysia-server.ts &  # Run elysia server with Bun
autocannon http://localhost:3000 -d 10 -c 100
pkill -f "bun run elysia-server.ts"

#Benchmark Bun files
Write-Host "\nBun files tests"
bun run bun-files.ts

#Benchmark Bun sqlite
Write-Host "\nBun sqlite tests"
bun run bun-sqlite.ts
