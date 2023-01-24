#!/bin/bash

# The kata script

#############################################
# 1 - Create a new repo                     #
#############################################

# 1.1 - Create the directory on your local file system
mkdir js-bowling-kata && cd $_

git init .

# 1.2 - Add a .gitignore file to exclude uneeded files
wget -O .gitignore https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore
echo "
.vscode/
package-lock.json" >> .gitignore

# 1.3 - Use the latest long term support version of node
nvm install lts/*
echo `nvm version lts/*` >| .nvmrc
nvm use

# 1.4 - Create a package.json file
echo '{
  "scripts": {
    "test": "NODE_ENV=test jest"
  }
}' >| package.json

# 1.5 - Add the jest testing framework
npm install --save-dev jest
echo "module.exports = {
  clearMocks: true,
  testMatch: ['**/specs/**/*.spec.js?(x)'],
};" >| jest.config.js

# 1.6 - Write an object named Game that has a roll(pins) and score() methods
# 1.6.a - `roll(pints)` is called each time the player rolls a ball.  
#         The argument is the number of pins knocked down.
# 1.6.b - `score()` is called only at the very end of the game.
#         It returns the total score for that game.
echo 'class Game {
  roll(pins) {}
  score() {
    return -1;
  };
};

module.exports = {
  Game,
};' >| game.js

git add .
git commit -m "Create new bowling kata"

###################################################
# 2 - Write our first test for the Game object  #
###################################################

# 2.1 - Write it to fail
echo "const { Game } = require('../src/game');

describe('Game', () => {
  it('should exist', () => {
    expect(Game).toNotBeDefined();
  });
});" >| specs/game.spec.js

npm run test # 1 failed, 1 total

# 2.2 - Write it to pass
sed -i 's/toNotBeDefined/toBeDefined/' specs/game.spec.js

npm run test # 1 passed, 1 total

git add .
git commit -m "Perform first test"

###################################################
# 3 - Write our second test for the Game object  #
###################################################

# 3.1 - Write it to fail

echo "const { Game } = require('../src/game');

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
});" >| specs/game.spec.js

npm run test # 1 failed, 1 passed, 2 total

# 3.2 - Write it to pass
sed -i 's/return -1;/return 0/' src/game.js

npm run test # 2 passed, 2 total

git add .
git commit -m "Perform second test"

###################################################
# 4 - Write our third test for the Game object  #
###################################################

# 4.1 - Write it to fail


