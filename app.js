const http = require('http');
const fs = require('fs');
const path = require('path');

const port = 9000


const server = http.createServer((req, res) => {
    if (req.url === '/') {
        const file = path.join(__dirname, 'SPA', 'index.htm');
        fs.readFile(file, (err, data) => {
            if (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end('Internal Server Error');
                return;
            }

            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(data);
        })
    }
    else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('404 Not Found');
    }
})


server.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});