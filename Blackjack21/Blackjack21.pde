Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();
Hand splitHand;

boolean roundOver = false;
boolean playerTurn = true;
boolean beforePlay = true;
boolean troll = false;
boolean doubleDown = false;
boolean doubleDownAsk = false;
boolean split = false;
boolean splitAsk = false;
boolean workable = true; 
boolean oneHand = false;
boolean lostHandOne = false;
boolean lostHandTwo = false;
boolean naturalBlackjack = false;
PImage back;

void setup() {
  playerTurn = true;
  back = loadImage("Cards/back.png");
  back.resize(180, 261);
  size(1000, 800);
  background(#39FF20);
  banner();
  doubleDown = false;
  split = false;
  splitAsk = false;
  doubleDownAsk = false;
  workable = true;



  fill(255);
  rect(32, 90, 265, 170);
  fill(0);
  text("CONTROLS", 160, 120);
  text("Start - ENTER", 120, 160);
  text("Hit - 'H'", 93, 200);
  text("Stand - 'S'", 105, 240);
  textAlign(LEFT);
  fill(255);
  rect(32, 270, 350, 200);
  fill(0);
  text("Message Center:", 40, 295);
}



void banner() {
  String title = "The Game of Blackjack";
  fill(255);
  rect(250, 5, 500, 75);
  fill(0);
  textSize(40);
  textAlign(CENTER);
  text(title, 500, 45);
  textSize(20);
  text("The House Always Wins! Play at your own risk :-)", 500, 70);
}



void handSetup() {
  textAlign(LEFT);
  displayCards(theHouse.getHand(), 430, 130);
  text("Player", 470, 700);
  displayCards(thePlayer.getHand(), 430, 500);
  if (split) {
    displayCards(splitHand, 30, 500);
    fill(255);
    rect(30, 765, 245, 30);
    fill(0);
    text("The Player -- Sum: " + splitHand.getSum(), 40, 787);
  }
}




void draw() {
  if (!troll) {
    textSize(20);
    handSetup();
    fill(255);
    rect(430, 100, 250, 25);
    rect(430, 765, 245, 30);
    rect(30, 10, 200, 70);
    fill(0);
    if (playerTurn) {
      text("The Dealer -- Sum: ? ? ? ", 440, 120);
    }
    if (!playerTurn) {
      text("The Dealer -- Sum: " + theHouse.getHand().getSum(), 440, 120);
    }
    if (beforePlay) {
      text("The Player -- Sum: ? ? ? ", 440, 787);
    }
    if (!beforePlay) {
      text("The Player -- Sum: " + thePlayer.getHand().getSum(), 440, 787);
    }
    text("Wallet: "  + thePlayer.getWallet(), 37, 32);
    text("Bet: " + thePlayer.getbet(), 37, 55);
    if (!split && !doubleDown) {
      text("Play Mode: Normal", 37, 75);
    }
    if (split) {
      text("Play Mode: Split", 37, 75);
    }
    if (doubleDown) {
      text("Play Mode: DD", 37, 75);
    }
    if (!beforePlay && thePlayer.getHand().getHandLength() == 2 && workable && !split && !doubleDown) {
      checkBlackjack();
      if (!naturalBlackjack) {
        if (
          thePlayer.getHand().getCard(0).getValue() == thePlayer.getHand().getCard(1).getValue() &&
          thePlayer.getHand().getCard(0).getStringValue().equals(thePlayer.getHand().getCard(1).getStringValue()) &&
          thePlayer.getHand().getCard(0).getValue() != 5
          ) {
          splitAsk = true;
          playerTurn = false;
          messageCenter("Would you like to split your hand?\nY/N");
        }
        if (thePlayer.getHand().getSum()  == 10 || thePlayer.getHand().getSum() == 11) {
          playerTurn = false;
          doubleDownAsk = true;
          messageCenter("Would you like to double down?\nY/N\nNote this action will double\nyour bet");
        }
      }
    }
    if (troll) {
    }
  }
}


void keyPressed() {
  if (!beforePlay && playerTurn) {
    if (key == 's') {
      if (!split) {
        playerTurn = false;
        play();
      } else if (oneHand) {
        oneHand = false;
      } else {
        playerTurn = false;
        splitPlay();
      }
      // Insert split code here
    }
    if (key == 'h') {
      if (!split) {
        thePlayer.getHand().Hit(masterDeck);
        if (thePlayer.getHand().getSum() > 21) {
          playerTurn = false;
          endRound(2, false);
        }
      } else if (oneHand) {
        splitHand.Hit(masterDeck);
        if (splitHand.getSum() > 21) {
          messageCenter("1st split hand is a bust\nGo cry to your mommy");
          lostHandOne = true;
          oneHand = false;
        }
      } else {
        thePlayer.getHand().Hit(masterDeck);
        if (thePlayer.getHand().getSum() > 21) {
          messageCenter("2nd split hand is a bust\nGo cry to your mommy");
          lostHandTwo = true;
          playerTurn = false;
          splitPlay();
        }
      }
      // Insert split code here
    }
  }
  if (beforePlay) {
    if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0') {
      if (thePlayer.getbet() == 0) {
        thePlayer.makeBet(Character.getNumericValue(key));
      } else {
        thePlayer.addWallet(thePlayer.getbet());
        thePlayer.makeBet(thePlayer.getbet() * 10 + Character.getNumericValue(key));
      }
    }
  }
  if (beforePlay && keyCode == ENTER) {
    if (thePlayer.getbet() == 0) {
      messageCenter("Put some money down");
    } else if (thePlayer.getbet() % 25 != 0) {
      thePlayer.addWallet(thePlayer.getbet());
      messageCenter("You can only bet\nin intervals of $25");
      thePlayer.makeBet(0);
    } else {
      beforePlay = false;
      thePlayer.getHand().getCard(0).setReveal(true);
      thePlayer.getHand().getCard(1).setReveal(true);
      theHouse.getHand().getCard(1).setReveal(true);
    }
  }
  if (roundOver) {
    if (key == 'r') {
      noLoop();
      setup();
      theHouse = new Dealer();
      thePlayer.setHand(new Hand(0));
      loop();
      roundOver = false;
      beforePlay = true;
    }
  }
  if (splitAsk && key == 'y') {
    split = true;
    splitAsk = false;
    workable = false;
    playerTurn = true;
    oneHand = true;
    messageCenter("");
    split();
  }
  if (doubleDownAsk && key == 'y') {
    doubleDown = true;
    doubleDownAsk = false;
    workable = false;
    playerTurn = true;
    messageCenter("");
    doubleDown();
  }
  if (splitAsk && key == 'n') {
    splitAsk = false;
    split = false;
    workable = false;
    playerTurn = true;
    messageCenter("");
  }
  if (doubleDownAsk && key == 'n') {
    doubleDownAsk = false;
    doubleDown = false;
    workable = false;
    playerTurn = true;
    messageCenter("");
  }
}

void messageCenter(String message) {
  fill(255);
  rect(32, 270, 350, 200);
  fill(0);
  text("Message Center:", 40, 295);
  text(message, 40, 355);
}

void displayCards(Hand daHand, float x, float y) {
  for (int i = 0, j = 0; i < daHand.getHandLength(); i++, j += 50) {
    PImage card = loadImage("Cards/" + daHand.getCard(i).getImageString());
    card.resize(180, 261);
    if (daHand.getCard(i).isRevealed()) {
      image(card, x +j, y);
    } else {
      image(back, x +j, y);
    }
  }
}



void checkBlackjack() {
  boolean playerBJ = thePlayer.getHand().hasBlackjack();
  boolean houseBJ = theHouse.getHand().hasBlackjack();
  if (playerBJ && !houseBJ) {
    playerTurn = false;
    endRound(1, true);
    naturalBlackjack = true;
  } else if (!playerBJ && houseBJ) {
    playerTurn = false;
    endRound(2, true);
  } else if (playerBJ && houseBJ) {
    playerTurn = false;
    endRound(3, true);
  }
}



void doubleDown() {
  playerTurn = false;
  thePlayer.addWallet(thePlayer.getbet());
  thePlayer.makeBet(thePlayer.getbet() * 2);
  thePlayer.getHand().Hit(masterDeck);
  play();
}



/**
 * Split method will create a new hand and alternate
 */
void split() {
  splitHand = new Hand(thePlayer.getHand().removeCard(0));
  splitHand.Hit(masterDeck);
  thePlayer.getHand().Hit(masterDeck);
  thePlayer.getHand().setSum(thePlayer.getHand().getSum() - splitHand.getCard(0).getValue());
}



void play() {
  theHouse.getHand().getCard(0).setReveal(true);
  while (theHouse.getHand().getSum() < 17) {
    theHouse.getHand().Hit(masterDeck);
  }
  if (theHouse.getHand().getSum() > 21) {
    endRound(1, false);
  } else if (theHouse.getHand().getSum() > thePlayer.getHand().getSum()) {
    endRound(2, false);
  } else if (theHouse.getHand().getSum() < thePlayer.getHand().getSum()) {
    endRound(1, false);
  } else if (theHouse.getHand().getSum() == thePlayer.getHand().getSum()) {
    endRound(3, false);
  }
}



void splitPlay() {
  theHouse.getHand().getCard(0).setReveal(true);
  while (theHouse.getHand().getSum() < 17) {
    theHouse.getHand().Hit(masterDeck);
  }
  if (theHouse.getHand().getSum() > splitHand.getSum()) {
    lostHandOne = true;
  }
  if (theHouse.getHand().getSum() > thePlayer.getHand().getSum()) {
    lostHandOne = true;
  }
  if (lostHandOne && lostHandTwo) {
    thePlayer.makeBet(0);
  } else if (lostHandOne || lostHandTwo) {
    thePlayer.addWallet((int)(0.5 * thePlayer.getbet()));
    thePlayer.makeBet(0);
  } else {
    int push = 0;
    if (theHouse.getHand().getSum() == splitHand.getSum()) {
      push++;
    }
    if (theHouse.getHand().getSum() == thePlayer.getHand().getSum()) {
      push++;
    }
    if (push == 0) {
      thePlayer.addWallet(2 * thePlayer.getbet());
    } else if (push == 1) {
      thePlayer.addWallet((int)(1.5 * thePlayer.getbet()));
    } else {
      thePlayer.addWallet(thePlayer.getbet());
    }
  }
  thePlayer.makeBet(0);
  textSize(40);
  delay(500);
  text("Want to play again? \nPress R", 20, 700);
  roundOver = true;
}



void endRound(int mode, boolean wasBlackjack) {
  textSize(20);
  theHouse.getHand().getCard(0).setReveal(true);
  if (mode == 1) {
    if (wasBlackjack) {
      thePlayer.addWallet((int)(thePlayer.getbet() * 1.5) + thePlayer.getbet());
    } else {
      thePlayer.addWallet(thePlayer.getbet() * 2);
    }
    messageCenter("Lucky Ducky, I'll give you a \nlittle part of my vast fortune");
  } else if (mode == 2) {
    theHouse.getHand().getCard(0).setReveal(true);
    messageCenter("You Lose!\nI'll be taking your money.\nPlease come again");
  } else if (mode == 3) {
    thePlayer.addWallet(thePlayer.getbet());
    messageCenter("It seems you've matched me!\nYou'll lose when you play \nin the future");
  }
  thePlayer.makeBet(0);
  if (thePlayer.getWallet() != 0 && !split) {
    textSize(40);
    delay(500);
    text("Want to play again? \nPress R", 20, 700);
    roundOver = true;
  }
  if (thePlayer.getWallet() != 0 && split) {
    textSize(40);
    delay(500);
    text("Want to play again? \nPress R", 20, 700);
    roundOver = true;
  }
}
