const server = Bun.serve({
    port: 3000,
    routes: {
        "/users/:id": req => {
            let count = 0
            for(let i = 0; i < 10000000000; i++){
                count += 1;
            }
            return new Response(`Hello ${req.params.id} from Bun! ,and I counted to ${count}`);
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