const http=require('http');
const fs=require('fs');
const path=require('path');

const port=9000


const server=http.createServer((req,res)=>{
    if(req.url==='/'){
        const file=path.join(__dirname,'./SPA/index.htm');
        fs.readFile(file,(err,data)=>{
            if(err){
                res.writeHead(500,{'Content-Type':'text/plain'});
                res.end('Internal Server Error');
                return;
            }
            else{
                res.writeHead(200,{'Content-Type':'text/html'});
                res.end(data);
            }
        })

        res.writeHead(200,{'Content-Type':'text/html'});
        res.end('./SPA/index.htm');
    }
})


server.listen(port,()=>{
    console.log(`Server is running on port ${port}`);
});