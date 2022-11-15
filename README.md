# Ruby Connect Four

Completed as part of The Odin Project: Ruby.

## Description

A command line version of connect four, built using TDD.

## Learning objectives

- Use TDD to complete a project
- Gain familiarity with RSpec

## Secondary outcomes

While developing this project, I had to solve the issue of checking for a line of four counters on the board.

The solution I came up with involved four using an array of four direction vectors (Horizontal (Right), Vertical (Down), Diagonal (Right and Down), Anti-diagonal (Left and Down)). Using a cell on the grid as a starting point, I traversed the grid using these vectors and checked each cell visited against the starting cell's value. I stopped if the cell visited had a different value to the starting cell, or if I reached the edge of the grid.

By repeating this process for each cell, I could iterate across the whole grid in every direction. If I successfully made a connection of four, I could stop.

One downside to this solution is that it requires checking every direction from every cell. On a small board this is not an issue, but on a larger scale would add unncessary complexity.

A solution to this would be to check for a connection of four only from the last placed counter. This works because if the game has been won in the most recent turn, that counter must be a part of the connection of four. In order to implement this, the direction vectors would have to be paired (e.g. Left and Right = Horizontal), and the results of the traversal in each pair of directions combined to search for a connection of four.

## Live preview

[See a live preview on Replit.](https://replit.com/@splot-cell/ruby-connect-four?v=1#README.md)