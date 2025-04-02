async function readFiles() {
    for (let i = 1; i <= 10_000; i++) {
        await Bun.file(`../test-files/file-${i}.txt`).text();
    }
}

console.time('Bun');
readFiles().then(()=> console.timeEnd('Bun'));