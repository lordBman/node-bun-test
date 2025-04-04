import { Database } from 'bun:sqlite';

function query() {
    const db = new Database(':memory:');
    
    db.run('CREATE TABLE users (id INT, name TEXT)');
    console.time('Bun SQLite');
    const stmt = db.prepare('INSERT INTO users VALUES (?, ?)');
    for (let i = 0; i < 10_000; i++) stmt.run(i, `User-${i}`);
    db.run("DROP TABLE users")
}

const server = Bun.serve({
    port: 3000,
    routes: {
        "/all": (req) => {
            query();
            
            return new Response(`all done!`);
        },
    },
    fetch(req) {
      return new Response("Not Found", { status: 404 });
    },
    error(error) {
        console.error(error);
        return new Response(`Error: ${error.message}`, { status: 500 });
    }
});

console.log(`Server running on port: ${server.port}`);