import { Elysia } from 'elysia'

new Elysia()
	.get('/:id', (req)=>{
		req.params.id
	})
	.get('/*', ()=>{

	}).listen(3000)