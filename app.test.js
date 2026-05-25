const server = require('./app');

describe('Default 200 ok Test', () => {
    it('should successfully GET the root path', async () => {
        const response = await request(server).get('/');
        expect(response.statusCode).toBe(200);
    });
})


describe('Non Existing 404 Not ok Test', () => {
    it('shouldnt be successfully GET the root path', async () => { 
        const response = await request(server).get('/hidden');
        expect(response.statusCode).toBe(404);
    });
})