import { Database } from 'bun:sqlite';

const db = new Database(':memory:');

db.run('CREATE TABLE users (id INT, name TEXT)');
console.time('Bun SQLite');
const stmt = db.prepare('INSERT INTO users VALUES (?, ?)');
for (let i = 0; i < 10_000; i++) stmt.run(i, `User-${i}`);
db.run("DROP TABLE users")
console.timeEnd('Bun SQLite');