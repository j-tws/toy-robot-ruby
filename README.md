# :robot: A toy robot...toy app

A simple toy robot CLI app that I just do for fun, and it is an expansion to this [exercism toy robot simulator exercise](https://exercism.org/tracks/ruby/exercises/robot-simulator). Since this is a popular programming exercise among devs and I have not done it before.

## Getting started
1. Clone this repo in your desired folder:
`make clone`

2. Run dependencies:
`make run`

3. Run the app:
`make app`

## What to expect
You will be given a series of instructions printed and all you need to do is to follow the prompts!

**NOTE:** If anytime you want to exit the app, just input `exit` and the app will quit. 

### First part - Intro and board creation
Here you will be asked to create your board by inputing the amount of rows and columns you want.
```
---------------------------------------------------
|          WELCOME TO TOY ROBOT SIMULATOR         |
---------------------------------------------------


First by starting up your board!
Enter the amount of rows you want to have for your board:
```

You will see the board printed out if lets say you put in 5 by 5 grid board
```
5 ⬜ ⬜ ⬜ ⬜ ⬜
4 ⬜ ⬜ ⬜ ⬜ ⬜
3 ⬜ ⬜ ⬜ ⬜ ⬜
2 ⬜ ⬜ ⬜ ⬜ ⬜
1 ⬜ ⬜ ⬜ ⬜ ⬜
  1  2  3  4  5 
```

### Second part: Place your robot
You will be asked where to place your robot in the board, along with where the robot will first face.
Follow and key in accordingly and you will see your robot printed with the board.
```
This is where your robot start
5 ⬜ ⬜ ⬜ ⬜ ⬜
4 ⬜ ⬜ ⬜ ⬜ ⬜
3 ⬜ ⬜ 🤖 ⬜ ⬜
2 ⬜ ⬜ ⬜ ⬜ ⬜
1 ⬜ ⬜ ⬜ ⬜ ⬜
  1  2  3  4  5 
```

### Third and final part: Move your robot around!
You will be given a set of instructions on how to enter your command and what those command means.
```
Now the fun begins
You can enter a series of commands where you will see your robot moving around the board
Commands can be only either:
R, which means ask the robot to turn right from where it is currently facing
L, which means ask the robot to turn left from where it is currently facing
A, which means ask the robot to advance one cell from where it is facing


Example command: RLAR
It means it command the robot to turn right, turn left, advance a step, and finish by turning right
Enter your commands here:
```

So just input your command and you will see how the robot traverse along the board. That's pretty much it. :robot:

## Some thoughts
* Did this exercise after being 10 months as a junior dev, and I just want to see how I have progressed 
  * Overall I think I did improved in some ways like:
    * Manage to get to the outcome I anticipate
    * Able to solve some problems that I set for myself
    * Definitely more comfortable writing ruby code and familiarize writing the ruby way
    * Put in some thoughts for user experience (like showing x and y axis on board, print out errors when user give invalid input etc)
* Room for improvement:
  * Code could be structured better and cleaner
  * Did not TDD this. Was excited to just write implementation code and then only I wrote specs after.
  * Did not know how to test for user input and expected outcome for `app.rb` file
  * Maybe there is a better way to structure the CLI app file (`app.rb`) file
  * The biggest problem of all, which is I have a feeling there is more stuff could be improved, but I can't really pinpoint what those issues are.

* Some nice to have:
  * Colours. Usually when I do CLI apps I would like to colourize some text, just to make the app more vibrant. Gems like `colourize` could be used
  * Instead of printing out the robot bearing whenever a command is executed, it could replace the :robot: emoji with something that shows direction instead
  * Could place multiple robots and select which robot you want to command