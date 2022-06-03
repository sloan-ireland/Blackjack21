Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();
boolean roundOver = false;
boolean playerTurn = true;
boolean beforePlay = true;
boolean troll = false;
boolean doubleDown = false;
boolean doubleDownAsk = false;
boolean split = false; 
boolean splitAsk = false;
boolean workable = true;
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
    if (!beforePlay && thePlayer.getHand().getHandLength() == 2 && workable) {
      checkBlackjack();
      if (thePlayer.getHand().getCard(0).getValue() == thePlayer.getHand().getCard(1).getValue()) {
        splitAsk = true;
        messageCenter("Would you like to split your hand? Y/N");
      }
      if (thePlayer.getHand().getSum()  == 10 || thePlayer.getHand().getSum() == 11) {
        doubleDownAsk = true;
        messageCenter("Would you like to double down? Y/N");
      }
    }
    if (troll) {
    }
  }
}


void keyPressed() {
  if (!beforePlay && playerTurn) { 
    if (key == 's') {
      playerTurn = false;
      play();
    }
    if (key == 'h') {
      thePlayer.getHand().Hit(masterDeck);
      if (thePlayer.getHand().getSum() > 21) {
        playerTurn = false;
        endRound(2, false);
      }
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
  }
  if (doubleDownAsk && key == 'y') {
    doubleDown = true;
    doubleDownAsk = false;
    workable = false;

  }
  if (splitAsk && key == 'n') {
    splitAsk = false;
    split = false;

  }
  if (doubleDownAsk && key == 'n') {
    doubleDownAsk = false;
    doubleDown = false;
    workable = false;

  }
}  

void messageCenter(String message) {
  fill(255);
  rect(32, 270, 350, 200);
  fill(0);
  text("Message Center:", 40, 295);
  text(message,40, 355);
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
  } else if (!playerBJ && houseBJ) {
    playerTurn = false;
    endRound(2, true);
  } else if (playerBJ && houseBJ) {
    playerTurn = false;
    endRound(3, true);
  }
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

void endRound(int mode, boolean wasBlackjack) {
  textSize(20);
  theHouse.getHand().getCard(0).setReveal(true); 
  if (mode == 1) {
    if (wasBlackjack) {
      thePlayer.addWallet((int)(thePlayer.getbet() * 1.5) + thePlayer.getbet());
    } else {
      thePlayer.addWallet(thePlayer.getbet() * 2);
    }
    text("Lucky Ducky, I'll give you a little part of my vast fortune", 310, 450);
  } else if (mode == 2) {
    theHouse.getHand().getCard(0).setReveal(true);
    text("You Lose, I'll be taking your money. Please come again", 310, 450);
  } else if (mode == 3) {
    thePlayer.addWallet(thePlayer.getbet());
    text("It seems you've matched me! You'll lose when you play in the future", 310, 450);
  }
  thePlayer.makeBet(0);
  if (thePlayer.getWallet() != 0) {
    textSize(40);
    delay(500);
    text("Want to play again? \nPress R", 20, 700);
    roundOver = true;
  }
}
