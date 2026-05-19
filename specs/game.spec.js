import { Game } from '../src/game.js';

describe('Game', () => {
  let game = null;
  beforeEach(() => {
    game = new Game();
  });

  const rollMany = (n, pins) => {
    for (let i = 0; i < n; i++) {
      game.roll(pins);
    }
  };

  it('should exist', () => {
    expect(Game).toBeDefined();
  });

  it('should return score 0 when no pins are knocked down', () => {
    rollMany(20, 0);
    expect(game.score()).toBe(0);
  });

  it('should return score 20 when 1 pin is knocked down each roll', () => {
    rollMany(20, 1);
    expect(game.score()).toBe(20);
  });

  it('should return score 16 when 1 spare is rolled', () => {
    game.roll(5);
    game.roll(5);
    game.roll(3);
    rollMany(17, 0);
    expect(game.score()).toBe(16);
  });

  it('should return score 150 when all spares are rolled', () => {
    rollMany(21, 5);
    expect(game.score()).toBe(150);
  });

  it('should return score 24 when 1 strike is rolled', () => {
    game.roll(10);
    game.roll(3);
    game.roll(4);
    rollMany(16, 0);
    expect(game.score()).toBe(24);
  });

  it('should return score 300 when all strikes are rolled', () => {
    rollMany(12, 10);
    expect(game.score()).toBe(300);
  });
});
