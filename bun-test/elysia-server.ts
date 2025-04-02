import { Elysia } from 'elysia'

const elysia = new Elysia()
	.get('/users/:id', (req)=> `Hello ${req.params.id} from Bun with elysia!`)
	.get('/*', ()=> "Not Found");
    
elysia.listen(3000);
console.log(`Server running on port: ${elysia.server?.port}`);