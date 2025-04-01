import { Elysia, file } from 'elysia'

new Elysia()
	.get('/', 'LIMBUS COMPANY!!')
	.get('/said', file('don-quixote.gif'))
	.get('/stream', function* () {
		while(true)
			yield 'LIMBUS COMPANY!!'
	})
	.ws('/realtime', {
		message(ws, message) {
			ws.send('This is truly ideal')
		}
	})
	.listen(3000)