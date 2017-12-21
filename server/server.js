/**
 * Created by DQvsRA on 18.11.2017.
 */

// server.js
const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('./server/db.json');
const middlewares = jsonServer.defaults();

server.use(jsonServer.bodyParser);
server.use((req, res, next) => {
    console.log("Request url: " + req.url);
    if(req.url.indexOf("/todos") == 0)
    {
        if (req.method === 'POST') {
            const body = req.body;
            body.createdAt = Date.now();
            body.completed = (typeof body.completed === "string") ? body.completed === "true" : body.completed;
        }
    }
    // Continue to JSON Server router
    next();
});
server.use(middlewares);
server.use(router);

server.listen(process.env.PORT, () => {
    console.log('JSON Server is running')
});
