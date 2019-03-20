process.env.NODE_ENV = 'test';
  
const expect = require('chai').expect;
const game = require('../lib/Game');

describe('Game_spec', () => { 
  it('should return true', (done) => { 
    expect(true).to.eql(true);
    
    done();
  }); 
});
