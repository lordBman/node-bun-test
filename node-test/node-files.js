const fs = require('fs/promises');

async function readFiles() {
    for (let i = 0; i < 10_000; i++) {
        await fs.readFile(`../test-files/file-${i}.txt`, 'utf8');
    }
}

console.time('Node.js');
readFiles().then(() => console.timeEnd('Node.js'));