Write-Host "NodeJS Stsrtup time tests"
1..5 | ForEach-Object {
    Write-Host "Run $_ : $( (Measure-Command { node -e "console.log('Hello')" }).TotalSeconds ) seconds"
}

Write-Host "Bun Stsrtup time tests"
1..5 | ForEach-Object {
    Write-Host "Run $_ : $( (Measure-Command { bun -e "console.log('Hello')" }).TotalSeconds ) seconds"
}

#navigate into the node-test subfolder
Set-Location .\node-test

#Benchmark NodeJS server
Write-Host "NodeJS server tests"
Start-Job -Name "Node_Server_Job" -ScriptBlock { node index.js }  # Run server in background
Start-Sleep -Milliseconds 3000
autocannon -d 10 -c 100 http://localhost:3000/users/nobel   # 10 sec, 100 concurrent connections
$node_server_job = Get-Job -Name "Node_Server_Job"
if ($node_server_job) {
    Stop-Job $node_server_job
    Write-Host "Killed Node.js server process(es)."
} else {
    Write-Host "No matching Node.js process found."
}

Write-Host "NodeJS server with Express tests"
Start-Job -Name "Node_Express_Server_Job" -ScriptBlock { node express-server.js } # Run express server with NodeJS
Start-Sleep -Milliseconds 3000
autocannon -d 10 -c 100 http://localhost:3000/users/nobel 
$node_express_server_job = Get-Job -Name "Node_Express_Server_Job"
if ($node_express_server_job) {
    Stop-Job $node_express_server_job
    Write-Host "Killed Node.js express server process(es)."
} else {
    Write-Host "No matching Node.js express process found."
}

#Benchmark NodeJS files
Write-Host "NodeJS files tests"
node .\node-files.js

#Benchmark NodeJS sqlite
Write-Host "NodeJS sqlite tests"
node .\node-sqlite.js

#navigate into the bun-test subfolder
Set-Location ..\bun-test

#Benchmark Bun server
Write-Host "Bun server tests"
Start-Job -Name "Bun_Server_Job" -ScriptBlock { bun .\index.ts } # Run Bun server in the background
Start-Sleep -Milliseconds 3000
autocannon -d 10 -c 100 http://localhost:3000/users/nobel 
$bun_server_job = Get-Job -Name "Bun_Server_Job"
if ($bun_server_job) {
    Stop-Job $bun_server_job
    Write-Host "Killed Bun server process(es)."
} else {
    Write-Host "No matching Bun process found."
}

Write-Host "Bun server with Express tests"
Start-Job -Name "Bun_Express_Server_Job" -ScriptBlock { bun .\express-server.ts } # Run express server with Bun in the background
Start-Sleep -Milliseconds 3000
autocannon -d 10 -c 100 http://localhost:3000/users/nobel
$bun_express_server_job = Get-Job -Name "Bun_Express_Server_Job"
if ($bun_express_server_job) {
    Stop-Job $bun_express_server_job
    Write-Host "Killed Bun express server process(es)."
} else {
    Write-Host "No matching Bun express process found."
}

Write-Host "Bun server with Elysia tests"
Start-Job -Name "Bun_Eylsia_Server_Job" -ScriptBlock { bun .\elysia-server.ts } # Run elysia server with Bun in the background
Start-Sleep -Milliseconds 3000
autocannon -d 10 -c 100 http://localhost:3000/users/nobel  
$bun_elysia_server_job = Get-Job -Name "Bun_Eylsia_Server_Job"
if ($bun_elysia_server_job) {
    Stop-Job $bun_elysia_server_job
    Write-Host "Killed Bun Elysia server process(es)."
} else {
    Write-Host "No matching Bun Elysia process found."
}

#Benchmark Bun files
Write-Host "Bun files tests"
bun .\bun-files.ts

#Benchmark Bun sqlite
Write-Host "Bun sqlite tests"
bun .\bun-sqlite.ts

Set-Location ..\
Write-Host "done"