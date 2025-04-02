#!/bin/bash

echo -e "NodeJS startup time tests"
for i in {1..5}; do
    time node -e "console.log('Hello')"
done

echo -e "Bun startup time tests"
for i in {1..5}; do
    time bun -e "console.log('Hello')"
done

#navigate into the node-test subfolder
cd ./node-test

echo -e "NodeJS server tests"
# Start Node.js server in background
node index.js & NODE_SERVER_PID=$!
# Wait for server to start (adjust sleep time if needed)
sleep 3

# Run autocannon benchmark
autocannon http://localhost:3000/users/nobel -d 10 -c 100

# Kill the Node.js server
kill -9 $NODE_SERVER_PID 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Killed Node.js server process (PID: $NODE_SERVER_PID)."
else
  echo "No matching Node.js server process found."
fi

echo -e "NodeJS express server tests"
# Start Node.js express server in background
node express-server.js & NODE_EXPRESS_SERVER_PID=$!
# Wait for server to start (adjust sleep time if needed)
sleep 3

# Run autocannon benchmark
autocannon http://localhost:3000/users/nobel -d 10 -c 100

# Kill the Node.js server
kill -9 $NODE_EXPRESS_SERVER_PID 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Killed Node.js express server process (PID: $NODE_EXPRESS_SERVER_PID)."
else
  echo "No matching Node.js express process found."
fi

#Benchmark NodeJS files
echo -e "NodeJS files tests"
node ./node-files.js

#Benchmark NodeJS sqlite
echo -e "NodeJS sqlite tests"
node ./node-sqlite.ts

#navigate into the bun-test subfolder
cd ../bun-test

echo -e "Bun server tests"
# Start Bun server in background
node index.ts & BUN_SERVER_PID=$!
# Wait for server to start (adjust sleep time if needed)
sleep 3

# Run autocannon benchmark
autocannon http://localhost:3000/users/nobel -d 10 -c 100

# Kill the Node.js server
kill -9 $BUN_SERVER_PID 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Killed Bun server process (PID: $BUN_SERVER_PID)."
else
  echo "No matching Bun server process found."
fi

echo -e "Bun express server tests"
# Start Bun express server in background
node express-server.ts & BUN_EXPRESS_SERVER_PID=$!
# Wait for server to start (adjust sleep time if needed)
sleep 3

# Run autocannon benchmark
autocannon http://localhost:3000/users/nobel -d 10 -c 100

# Kill the Node.js server
kill -9 $BUN_EXPRESS_SERVER_PID 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Killed Bun express server process (PID: $BUN_EXPRESS_SERVER_PID)."
else
  echo "No matching Bun express server process found."
fi

echo -e "Bun elysia server tests"
# Start Bun elysia server in background
node elysia-server.ts & BUN_ELYSIA_SERVER_PID=$!
# Wait for server to start (adjust sleep time if needed)
sleep 3

# Run autocannon benchmark
autocannon http://localhost:3000/users/nobel -d 10 -c 100

# Kill the Node.js server
kill -9 $BUN_ELYSIA_SERVER_PID 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Killed Bun elysia server process (PID: $BUN_ELYSIA_SERVER_PID)."
else
  echo "No matching Bun elysia server process found."
fi

#Benchmark Bun files
echo -e "Bun files tests"
bun run ./bun-files.ts

#Benchmark Bun sqlite
echo -e "Bun sqlite tests"
bun ./bun-sqlite.ts

cd ../
echo -e "done"