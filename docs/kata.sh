#!/bin/bash

# The kata script

#############################################
# 1 - Create a new repo                     #
#############################################

# 1.1 - Create the directory on your local file system
mkdir js-bowling-kata && cd $_

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

# 1.6 - Write an object named Game that has a roll(pins) and score() methods
# 16.a - `roll(pints)` is called each time the player rolls a ball.  
#         The argument is the number of pins knocked down.
# 16.b - `score()` is called only at the very end of the game.
#         It returns the total score for that game.
echo 'const Game = () => {
  return {
    roll: (pins) => {},
    score: () => {},
  };
};

module.exports = {
  Game,
};' >| game.js


# 1.7 - Write our first test for the Game object.

# 1.7.a - Write it to fail
echo "const { Game } = require('../src/game');

describe('Game', () => {
  it('should exist', () => {
    expect(Game).toNotBeDefined();
  });
});" >| specs/game.spec.js

npm run test # 1 failed, 1 total

# 1.7.b - Write it to pass
sed -i 's/toNotBeDefined/toBeDefined/' specs/game.spec.js

npm run test # 1 passed, 1 total
