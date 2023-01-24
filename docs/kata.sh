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
  roll = (pins) => ();
  score = () => -1;
};

module.exports = {
  Game,
};' >| game.js

git add .
git commit -m "Create new bowling kata"

###################################################
# 2 - Write our "0" test for the Game object      #
#     This is our sanity check. =)                #
###################################################

# 2.1 - Write it to fail
echo "const { Game } = require('../src/game');

describe('Game', () => {
  // sanity check
  it('should exist', () => {
    expect(Game).toNotBeDefined();
  });

  // first test
});" >| specs/game.spec.js

npm run test # 1 failed, 1 total

# 2.2 - Write it to pass
sed -i 's/toNotBeDefined/toBeDefined/' specs/game.spec.js

npm run test # 1 passed, 1 total

git add .
git commit -m "Perform the sanity check"

###################################################
# 3 - Write our first test for the Game object  #
###################################################

# 3.1 - Write it to fail

sed -e "/first test/r"<(
    echo "
  it('should return score 0 when no pins are knocked down', () => {
    const game = new Game();
    for (let i = 0; i < 20; i++) {
      game.roll(0);
    }
    expect(game.score()).toBe(0);
  });
  
  // second test"
  ) -i -- specs/game.spec.js

npm run test # 1 failed, 1 passed, 2 total

# 3.2 - Write it to pass
sed -i 's/=> -1;/=> 0/' src/game.js

npm run test # 2 passed, 2 total

git add .
git commit -m "Perform the first test"

###################################################
# 4 - Write our second test for the Game object  #
###################################################

# 4.1 - Write it to fail

sed -e "/second test/r"<(
    echo "
  it('should return score 20 when 1 pin is knocked down each roll', () => {
    const game = new Game();
    for (let i = 0; i < 20; i++) {
      game.roll(1);
    }
    expect(game.score()).toBe(20);
  });

  // third test"
  ) -i -- specs/game.spec.js

npm run test # 1 failed, 2 passed, 3 total

# 4.2 - Write it to pass

echo "class Game {
  constructor() {
    this.total = 0;
  }
  roll = (pins) => (this.total += pins);
  score = () => this.total;
}

module.exports = {
  Game,
};" >| src/game.js

npm run test # 3 passed, 3 total

git add .
git commit -m "Perform the second test"

###################################################
# 5 - Keep it DRY so let's re-factor              #
###################################################

# 5.1 - Two additons to reduce the duplication:
#       5.1.a - Add a beforeEach() function to create a new Game object before each test
#       5.1.b - Add a rollMany() function to take care of the repetitive roll() calls
echo "const { Game } = require('../src/game');

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

  const rollSpare = () => {
    game.roll(5);
    game.roll(5);
  };

  const rollStrike = () => {
    game.roll(10);
  };

  it('should exist', () => {
    expect(Game).toBeDefined();
  });

  // first test

  it('should return score 0 when no pins are knocked down', () => {
    rollMany(20, 0);
    expect(game.score()).toBe(0);
  });

  // second test

  it('should return score 20 when 1 pin is knocked down each roll', () => {
    rollMany(20, 1);
    expect(game.score()).toBe(20);
  });

  // third test
});"

npm run test # 3 passed, 3 total (no change)

git add .
git commit -m "Refactor the tests"

###################################################
# 5 - Write our third test for the Game object  #
###################################################

# 5.1 - Write it to fail
sed -e "/third test/r"<(
    echo "
  it('should return score 16 when 1 spare is rolled', () => {
    rollSpare();
    game.roll(3);

    rollMany(17, 0;
    expect(game.score()).toBe(16);
  });

  // fourth test"
  ) -i -- specs/game.spec.js

npm run test # 1 failed, 3 passed, 4 total

# 5.2 - Write it to pass
#     5.2.a - A Game class kinda makes no sense when we think about how we should
#       score an actual bowling game.  Let's refactor it a bit
echo "class Game {
  constructor() {
    this.rolls = new Array(21);
    this.currentRoll = 0;
  }

  roll = (pins) => {
    this.rolls[this.currentRoll++] = pins;
  };

  score = () => {
    let score = 0;
    let frameIndex = 0;
    for (let frame = 0; frame < 10; frame++) {
      if (this.#isSpare(frameIndex)) {
        score += 10 + this.rolls[frameIndex + 2];
        frameIndex += 2;
      } else {
        score += this.rolls[frameIndex] + this.rolls[frameIndex + 1];
        frameIndex += 2;
      }
    }
    return score;
  };

  #isSpare = (frameIndex) =>
    this.rolls[frameIndex] + this.rolls[frameIndex + 1] === 10;
}

module.exports = {
  Game,
};" >| src/game.js

npm run test # 4 passed, 4 total

git add .
git commit -m "Perform the third test"

###################################################
# 6 - Write our fourth test for the Game object  #
###################################################

# 6.1 - Write it to fail
sed -e "/fourth test/r"<(
    echo "
  it('should return score 24 when 1 strike is rolled', () => {
    rollStrike();
    game.roll(3);
    game.roll(4);

    rollMany(16, 0);
    expect(game.score()).toBe(24);
  });

  // fifth test"
  ) -i -- specs/game.spec.js

npm run test # 1 failed, 4 passed, 5 total

# 6.2 - Write it to pass

echo "class Game {
  constructor() {
    this.rolls = new Array(21);
    this.currentRoll = 0;
  }

  roll = (pins) => {
    this.rolls[this.currentRoll++] = pins;
  };

  score = () => {
    let score = 0;
    let frameIndex = 0;
    for (let frame = 0; frame < 10; frame++) {
      if (this.#isStrike(frameIndex)) {
        score += 10 + this.#strikeBonus(frameIndex);
        frameIndex++;
      } else if (this.#isSpare(frameIndex)) {
        score += 10 + this.#spareBonus(frameIndex);
        frameIndex += 2;
      } else {
        score += this.#sumOfBallsInFrame(frameIndex);
        frameIndex += 2;
      }
    }
    return score;
  };

  #isSpare = (frameIndex) =>
    this.rolls[frameIndex] + this.rolls[frameIndex + 1] === 10;

  #isStrike = (frameIndex) => this.rolls[frameIndex] === 10;

  #sumOfBallsInFrame = (frameIndex) =>
    this.rolls[frameIndex] + this.rolls[frameIndex + 1];

  #spareBonus = (frameIndex) => this.rolls[frameIndex + 2];

  #strikeBonus = (frameIndex) =>
    this.rolls[frameIndex + 1] + this.rolls[frameIndex + 2];
}

module.exports = {
  Game,
};" >| src/game.js

npm run test # 5 passed, 5 total

git add .
git commit -m "Perform the fourth test"

###################################################
# 7 - Write our fifth test for the Game object  #

# 7.1 - Write it to fail

sed -e "/fifth test/r"<(
    echo "
  it('should return score 300 when all strikes are rolled', () => {
    rollMany(12, 10);
    expect(game.score()).toBe(299);
  });"
  ) -i -- specs/game.spec.js

npm run test # 1 failed, 5 passed, 6 total

# 7.2 - Write it to pass
sed -i -- 's/299/300/' specs/game.spec.js

npm run test # 6 passed, 6 total

git add .
git commit -m "Perform the fifth test"

echo "Finis."




