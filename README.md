# AnimalGame-2.0
My course project for the course Functional Programming @ FMI. It's a version of the famous Akinator, but instead of celebrities the program try to guess an animal. 

## How to run
https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ghci.html

## How to play
The game will ask you some questions and from the answer will ask you a new one or will guess the animal. If it suggests a wrong animal it will ask from the user to type the correct answer and one question that will distinct this animal.

## How does it work
The program in itself builds a binary tree. You start with a single questions and two animals and Y goes one way while N the other. When you reach an animal it's stops and tries to guess it, if it's right is game over and if it's wrong it asks you for question which will replace the current leaf and will add two new ones one for the correct animal and one for the wrong guess

## What is to be done
For starters the program doesn't have a check if you lie somewhere down the tree, the concept is clear but it isn't implemented. Second - the program can be made to read the data from file, so it will remove the hardcoded data and will have the ability to save every time you play
