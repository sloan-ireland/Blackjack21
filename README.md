# Blackjack21
**The wonderful game of blackjack in all its glory! The house always wins :-)**

###### Group Name:
The House
###### Group members:
Sloan Ireland, Nurdaulet Kaishibayev
###### Brief Project Description:
Our project consists of a single-player card game of Blackjack. There will be a dealer/house that the player will have to play against. The dealer will randomly deal (2) shuffled cards from 4 decks to the player and himself with each competing to get the highest card number combination without going over 21. Card distribution is randomized from the remaining cards that have not been dealt. Special-type bets such as splitting and double-down are possibly going to be implemented. Furthermore, draws and natural 21s will be included. The eventual goal will be to add Insurance against the Dealer having a blackjack. Rules for blackjack will be listed in the READ ME file.

###### Link to Design Document:
[DA Document](https://docs.google.com/document/d/14e9wDzL2M29oHePiIcvPqf9Y1P8A0Q__MjswjDk05i8/edit?usp=sharing)

###### Blackjack rules:
The goal of the game is to get (or as close to) 21 with cards without going over while beating the dealer's hand in which case the bet placed by the player before the hand began will be paid by the dealer.

The player to the left goes first and must decide whether to "stand" (not ask for another card) or "hit" (ask for another card in an attempt to get closer to a count of 21, or even hit 21 exactly). They may ask the dealer for additional cards, one at a time, until deciding to stand on the total (if it is 21 or under), or goes "bust" (if it is over 21).

When the dealer has served every player, the dealers face-down card is turned up. If the total is 17 or more, it must stand. If the total is 16 or under, they must take a card. The dealer must continue to take cards until the total is 17 or more, at which point the dealer must stand.

Face cards all count as 10 and all other cards represent their normal value. Ace is the exception as it can be counted as 1 or 11. Its default value is an 11, but if a hand with an Ace (counted as 11) in it busts, the Ace automatically counts as a 1 and the hand is not busted.

Payout: If the player had a natural blackjack (21 was reached between the first two cards) and the dealer doesn't have a natural blackjack the player immediately gets paid 1.5x his original bet. On a normal hand if the player beats the dealer, they get paid 1x their original bet. If they lose the dealer takes the bet. If a push occurs, no money is given or taken.

###### Compile/Run Instructions:
1) After opening the processing file, hit the green RUN button on the top left corner.

2) Make a bet using the numbers (top row of numbers on keyboard) within the wallet range.

3) Click ENTER to start the game.

4) Clicking "S" calls STAND.

5) Clicking "H" calls HIT.

6) When the round is over (given the player's wallet isn't empty), click "R" to restart the round.

7) If all money is lost, a black screen will appear --> RE-OPEN the game.

**Special Plays and Betting Cases**

Disclaimer: Anything listed here below is not supported by the our current blackjack version

Spliting: If a player's first two cards are of the same denomination, such as two jacks or two sixes, they may choose to treat them as two separate hands when their turn comes around. The amount of the original bet then goes on one of the cards, and an equal amount must be placed as a bet on the other card. Note that payouts for natural blackjacks do not apply for split Aces. The dealer can end up with 21 causing a push.

Double-down: Another option open to the player is doubling their bet when the original two cards dealt total 9, 10, or 11. When the player's turn comes, they place a bet equal to the original bet, and the dealer gives the player just one card, which is placed face down and is not turned up until the bets are settled at the end of the hand.


###### Progress Log:
-=-=-= 5/18 =-=-=-


Sloan --> Copied the basic group and project info from the google doc to the read me.

Sloan and Nurdaulet --> Worked on prototype to figure out what classes fit together.
Also created branches and a test file to figure out merge conflicts


-=-=-= 5/19 =-=-=-


Sloan --> Added blackjack rules to the readme

Sloan and Nurdaulet --> Continued working on prototype


-=-=-= 5/20 =-=-=-


Nurdaulet --> Worked on the Outline methods and classes. Also started working on the Development stages w/ dropdown for status

Sloan --> Finished the outline methods


-=-=-= 5/22 =-=-=-


Nurdaulet & Sloan --> Finished the UML diagram with all written classes and methods

Nurdaulet --> Finished the Development Stages

Sloan --> Added pictures of cards to temporary folder in directory


-=-=-= 5/23 =-=-=-


Nurdaulet --> Created all processing files and imported them into the repository in class. Started and finished working on the Deck class + started working on the Dealer class.

Sloan --> Finished the card class


-=-=-= 5/24 =-=-=-


Sloan --> modified the deck class and started working on Hand class

Nurdaulet --> Finished the Player and Dealer classes


-=-=-= 5/25 =-=-=-


Nurdaulet --> Continued working on the Card, Player, Dealer, and Deck classes. Added PImage handling for the cards so you don't have to call the method 53 times for each card. Also added accessor + mutator methods for other classes

Sloan -- > finished the Hand class. modified other classes with additional methods as nessesary to help in hand class (e.g checkBlackjack). started methods in blackjack21


=-=-=- 5/26 =-=-=-
Sloan --> Continued working on main Blackjack21 file. spent time playing around with PImages and how to display them outside of calling them in set up. Read documentation


-=-=-= 5/26-27 =-=-=-

Nurdaulet --> Tested PImage assigning and loading inside setup() when drawing a card from deck.


=-=-=- 5/27 =-=-=-


Sloan --> Added banner and cardset up methods. played around with display functions for showing game functionality.


-=-=-= 5/28 =-=-=- (SPECIAL DATE: Worked on one branch while the other experimented with functionalities, but didn't commit: Used screen sharing)


Nurdaulet --> Experimented with drawing cards and displaying them when hitting and standing. Added a small portion to test that hitting and standing changes modes and switches to the other mode.

Sloan --> Wrote most of the game logic in the main file including play() and endRound(). redid parts of checkBlackjack. Started getting actual display functionality with keyPressed(). Experimented with different card drawings. Discovered error with counting Aces that needs to be fixed.  


-=-=-= 5/29 =-=-=-


Sloan --> made game looping functionality with hitting R to reset the cards and start a new round. Implemented a betting system, but need to fix the error where u get more money when wallet is zero.


-=-=-= 5/30 =-=-=- (SPECIAL DATE: Worked on one branch while the other experimented with functionalities, but didn't commit: Used screen sharing)


Sloan --> fixed minor errors and bugs. finalized the display and logic for when you run out of money.

Nurdaulet --> Fixed the betting issue where going over displayed negative numbers and infinite wallet. Helped Sloan run through code and find minor bugs and errors to fix.


-=-=-= 5/31 =-=-=-


Nurdaulet --> Worked on proper displaying of splitting and doubling down: Incorrect display when the prompt window shows up. Fixed the message box error with improper aligning.
