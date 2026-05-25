let http=require('http');
let server=http.createServer((req,res)=>{
    res.write("Hello World");
    res.end();
}).listen(3030,()=>{
    console.log("Server is running on port 3030");
});