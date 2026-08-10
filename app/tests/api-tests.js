'use strict';
const request = require('supertest');
const expect = require('chai').expect;
const describe = require('mocha').describe;
const it = require('mocha').it;
const after = require('mocha').after;

const app = require('../server');

describe('API Tests', () => {
    after(async () => {
        // leave the database clean for the next test run
        await request(app).delete('/api/names');
    });

    it('GET /api/random_name returns a first and last name', async () => {
        const res = await request(app).get('/api/random_name');
        expect(res.status).to.eq(200);
        expect(res.body.firstName).to.be.a('string');
        expect(res.body.lastName).to.be.a('string');
    }).timeout(5000);

    it('GET /api/connection returns MongoDB connection info', async () => {
        const res = await request(app).get('/api/connection');
        expect(res.status).to.eq(200);
        expect(res.body.connectionInfo).to.be.an('object');
    }).timeout(5000);

    it('POST /api/names then GET /api/names includes the saved name', async () => {
        const newName = { firstName: 'Testy', lastName: 'McTestFace' };

        const postRes = await request(app).post('/api/names').send(newName);
        expect(postRes.status).to.eq(200);

        const getRes = await request(app).get('/api/names');
        expect(getRes.status).to.eq(200);
        const found = getRes.body.find(
            (n) => n.firstName === newName.firstName && n.lastName === newName.lastName
        );
        expect(found).to.not.be.undefined;
    }).timeout(5000);

    it('DELETE /api/names clears the saved list', async () => {
        await request(app).post('/api/names').send({ firstName: 'Temp', lastName: 'Person' });

        const delRes = await request(app).delete('/api/names');
        expect(delRes.status).to.eq(200);

        const getRes = await request(app).get('/api/names');
        expect(getRes.body).to.have.lengthOf(0);
    }).timeout(5000);
});
