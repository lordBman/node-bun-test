const http = require('http');
const sqlite3 = require('sqlite3').verbose();
const url = require('url');

const server = http.createServer((req, res) => {
    const { method } = req;
    const parsedUrl = url.parse(req.url, true);

    // Dynamic route: "/users/:id"
    if (method === 'GET' && parsedUrl.pathname.startsWith('/users/')) {
        const name = parsedUrl.pathname.split('/')[2];
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(`Hello ${name}!`);
    } else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('404 Not Found');
    }
});

server.listen(3000, () => {
    console.log('Listening on localhost:3000');
});