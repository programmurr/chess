# CHESS

## WORK IN PROGRESS
*This project is being made via TDD with the red-green-refactor approach. At times this code will smell a little as I try to get tests to pass. I will do my best to avoid that happening in the first place, but I hope it shows a clear evolution compared to code I have written for previous exercises. Consistent refactoring will take place over time, and such smells will be removed to the best of my ability for the finished product. My aim is to demonstrate clear progression in code writing ability, and to show that I can maintain that progression towards clearer, maintainable code.* 

### Assignment:

1. Build a command line Chess game where two players can play against each other.
2. The game should be properly constrained – it should prevent players from making illegal moves and declare check or check mate in the correct situations.
3. Make it so you can save the board at any time (remember how to serialize?)
4. Write tests for the important parts. You don’t need to TDD it (unless you want to), but be sure to use RSpec tests for anything that you find yourself typing into the command line repeatedly.
5. Do your best to keep your classes modular and clean and your methods doing only one thing each. This is the largest program that you’ve written, so you’ll definitely start to see the benefits of good organization (and testing) when you start running into bugs.
6. Have fun! Check out the unicode characters for a little spice for your gameboard.
7. (Optional extension) Build a very simple AI computer player (perhaps who does a random legal move)

### Personal Objectives:

1. Build using TDD
 - While TDD for Connect4 was thorough, I learned I didn't use mocks and stubs as properly/correctly as I should have, so I will continue improving TDD practice with this project
2. The board will be an actual checkered board with the unicode characters displayed on top. Not just blank spaces represented with ' - ' like all my projects before
3. Make a fancy README with gifs displaying game behaviour
4. Board coordinates will use the proper chess notation of a1, e4, etc.
5. Graphically display captured pieces
6. Follow the rules of chess to the letter

