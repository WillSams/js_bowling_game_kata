# Bowling Game - A JavaScript TDD Story

The now classic bowling game kata by Bob Martin.  This is a great kata to practice TDD and BDD.  The kata is described in detail in [Agile Principles, Patterns, and Practices in C#][1] and [Bowling Game Kata][2].

## Specification

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

## The Kata

I've created a simple shell script that should be able to followed along on Linux, Mac, or Windows. The script can be read [here][3].

[1]: https://www.goodreads.com/book/show/84983.Agile_Principles_Patterns_and_Practices_in_C_
[2]: http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata
[3]: ./docs/kata.sh
