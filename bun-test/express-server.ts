import express from "express";

const app = express();

// Dynamic route with Express
app.get('/users/:id', async(req, res) => {
    res.status(200).send(`Hello ${req.params.id} from Bun with express!`);
});

app.use(async(req, res)=>{
    res.status(404).send("Not Found")
});

app.listen(3000, () => {
    console.log('Express server running on http://localhost:3000');
});