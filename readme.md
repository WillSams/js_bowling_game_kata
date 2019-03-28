# Bowling Game - A JavaScript TDD Story
========================================

Ever since I started the quest to become agile after reading ['Agile Principles, Patterns, and Practices in C#' by Robert "Uncle Bob Martin and Micah Martin][1], whenever I wanted to learn a new language I began with the reliable bowling game example.  When I became interested in learning Ruby back in 2015, I figured doing TDD in Ruby would be the best way so I became interested in a [tutorial][2] and [example][3] I found.  My JavaScript tutorial is based on my [Ruby][4] example.  Hopefully, this eventually becomes a good tutorial for anyone who wants to learn [TDD/BDD][8] while picking up Node.js and modern JavaScript.  I'll complete this tutorial when time permits.  Tentatively shooting for March 2019.

All of my instructions will be for Debian based systems (Ubuntu, Linux Mint).  Ctrl-T to open up your terminal, we are going to live at the command-line.  You don't need to grasp much of what we are doing until we get to the programming part.  For editing code, we will be using Vim.  I'm going to be bold here:  if you learn to live at the command-line and use Vim or Emacs, you will become a more productive programmer.  There, I said it.  If you aren't familiar with Vi or Vim, there are many wonderful [tutorials][7] online.

### Specification
Before we write a single line of code, let's write our "specs".  What are we attempting to design?

    1) Scoring basics - 10 frames, 10 pins used for scoring, minimum score is 0 and a max is 300.
    2) Implement basic scoring - 10 frames of 2 rolls each.  Normal rolls are 1 point per pin.
    3) Strikes and spare strikes - 1 roll to knock all 10 are strikes (X), 2 rolls to knock all 10 are spares (/).
    4) Scoring strikes - If first throw, (10+a).  If spare, 10 + a.  Max 30 for first, max 20 for second.
    5) Focus on frames for scoring - score is a sum of individual frames.  Note: strikes causes frame crossover.
    6) Implement spare scoring - Spare scoring crossing frames still count for that frame.
    7) Scoring a strike - Finish implementing logic from #3.
    8) Implement scoring considering strikes - Strike scoring crossing frames still count for that frame.
    9) 10th Frame - If strike or spare is rolled, bowler gets extra ball.  This should make it 21 or less rolls.

### Installing nodejs and npm.  Add ~/.npm-global to your path    
    mkdir ~/.npm-global
    
    echo -e "export NPM_CONFIG_PREFIX=$HOME/.npm-global" >> ~/.bashrc
    echo -e "PATH=$PATH:$HOME/.npm-global/bin" >> ~/.bashrc  
      
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
      
    sudo apt update && apt upgrade -y 
    sudo apt install vim git nodejs -y
    
    sudo npm config set prefix '/home/$USER/.npm-global' 
    sudo chown $USER:$USER -R $HOME/.config

### Install [Mocha][5] globally. 
Mocha is a test framework.  After install, it will sit in ~/.npm-global.

    npm i -g mocha
    
### Setup your project.  
    PROJECT=$HOME/Projects/jsdev/bowling_game
    mkdir -p $PROJECT $PROJECT/app $PROJECT/lib $PROJECT/specs
    
    cd $PROJECT
  
    echo "node_modules/" >> $PROJECT/.gitignore && git init .
      
    echo "{}" >> $PROJECT/package.json && npm i
    
    touch $PROJECT/lib/Game.js
    
### Install [Chai][6] locally.
Chai is an assertion library.  After install, it will sit in $PROJECTS/node_modules.

    npm i --save-dev chai 
    
### Write your first test.  

Open Vim.  As mentioned earlier, we will be living at the command-line.

    vim $PROJECT/specs/Game_spec.js
    
Once the editor is open, hit the 'i' key to begin editing within your Vim session.

    process.env.NODE_ENV = 'test';
  
    const expect = require('chai').expect;
    const game = require('../lib/Game');

    describe('Game_spec', () => { 
      it('should return true', (done) => { 
        expect(true).to.eql(true);
        
        done();
      }); 
    });
    
While still in Vim, type ':wq' to close it.  Now, time to check our test.

        mocha specs/Game_spec.js
    
Of course, this will pass.  For now on, we'll begin the 'fail-pass-refactor' paradigm when writing tests.  
    
### TODO:  The rest of this tutorial when I find the time....
    To be continued....    
    
[1]: https://www.goodreads.com/book/show/84983.Agile_Principles_Patterns_and_Practices_in_C_
[2]: http://butunclebob.com/files/downloads/Bowling%20Game%20Kata.ppt
[3]: https://github.com/k00ka/bowling-game-kata/tree/david_final
[4]: https://github.com/WillSams/ruby_bowling_game_kata
[5]: https://mochajs.org/
[6]: https://www.chaijs.com/
[7]: https://www.openvim.com/
[8]: https://www.toptal.com/freelance/your-boss-won-t-appreciate-tdd-try-bdd

