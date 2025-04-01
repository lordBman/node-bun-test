import express from "express";

const app = express();

// Dynamic route with Express
app.get('/users/:id', (req, res) => {
  res.json({ userId: req.params.id });
});

app.listen(3000, () => {
  console.log('Express server running on http://localhost:3000');
});