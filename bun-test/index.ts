const server = Bun.serve({
    port: 3000,
    routes: {
        "/users/:id": req => {
            return new Response(`Hello ${req.params.id}!`);
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