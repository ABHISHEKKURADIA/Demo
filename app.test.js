const server=require('./app');

describe('Default 200 ok Test', () => {
    const response = await request(server).get('/');
    expect(response.statusCode).toBe(200);
})


describe('Non Existing 400 Not ok Test', () => {
    const response = await request(server).get('/random');
    expect(response.statusCode).toBe(400);
})