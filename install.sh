#!/bin/bash

echo -e "installing required packages"

#ensure autocannon is install, which will be used to test the servers of the NodeJS and Bun
npm install -g autocannon

#navigate into the node-test subfolder
cd ./node-test

#install required packages for Node to run
npm install

#navigate into the bun-test subfolder
cd ../bun-test

#install required packages for Bun to run
bun install

echo -e "required packages installation successful"

cd ../

echo -e "checking if test folder and file exists"
# Generate test files (10,000 empty files)
folder="./test-files"
# Create the directory if it doesn't exist
if [ ! -d "$folder" ]; then
    mkdir -p "$folder"
    echo "Created directory: $folder"
    
    # Generate 1000 empty files
    for i in {1..1000}; do
        touch "$folder/file-$i.txt"
    done
    echo "Created 1000 test files in $folder/"
else
    echo "Directory $folder already exists. Skipping file creation."
fi

echo -e "done"