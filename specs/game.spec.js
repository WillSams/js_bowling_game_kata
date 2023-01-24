const { Game } = require('../src/game');

describe('Game', () => {
  it('should exist', () => {
    expect(Game).toBeDefined();
  });

  it('should return score 0 when no pins are knocked down', () => {
    const game = new Game();
    for (let i = 0; i < 20; i++) {
      game.roll(0);
    }
    expect(game.score()).toBe(0);
  });
});
