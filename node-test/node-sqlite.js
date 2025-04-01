const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database(':memory:');

db.serialize(() => {
  db.run('CREATE TABLE users (id INT, name TEXT)');
  console.time('Node.js SQLite');
  const stmt = db.prepare('INSERT INTO users VALUES (?, ?)');
  for (let i = 0; i < 10_000; i++) stmt.run(i, `User-${i}`);
  stmt.finalize();
  console.timeEnd('Node.js SQLite');
});