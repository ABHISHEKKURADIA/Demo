const http=require('http');
const port=9000


const server=http.createServer((req,res)=>{
    if(req.url==='/'){
        res.writeHead(200,{'Content-Type':'text/html'});
        res.end('./SPA/index.htm');
    }
})


server.listen(port,()=>{
    console.log(`Server is running on port ${port}`);
});