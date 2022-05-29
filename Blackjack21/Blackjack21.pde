Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();
boolean roundOver = false;
boolean playerTurn = true;
boolean beforePlay = true;

PImage back; 

void setup() {
  playerTurn = true;
  back = loadImage("Cards/back.png");
  back.resize(180, 261); 
  size(1000, 800);
  background(#39FF20);
  banner();
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
  textSize(20);
  handSetup();
  fill(255);
  rect(430,100, 250,25);
  rect(430,765, 245, 30);
  rect(30,90,200,55);
  fill(0);
  if (playerTurn) {
   text("The Dealer -- Sum: ? ? ? " , 440, 120);
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
  text("Wallet: "  + thePlayer.getWallet(), 37, 112);
  text("Bet: " + thePlayer.getbet(), 37,135);
  if (!beforePlay){
  checkBlackjack();
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
        }
        else {
          thePlayer.addWallet(thePlayer.getbet());
          thePlayer.makeBet(thePlayer.getbet() * 10 + Character.getNumericValue(key));
        }
      }
   }
   if (beforePlay && keyCode == ENTER) {
     beforePlay = false;
     thePlayer.getHand().getCard(0).setReveal(true);
     thePlayer.getHand().getCard(1).setReveal(true);
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
  //theHouse.getHand().getCard(0).setReveal(true);
  while (theHouse.getHand().getSum() < 17) {
    theHouse.getHand().Hit(masterDeck);
  }
  if (theHouse.getHand().getSum() > 21) {
    endRound(1, false);
  }
  else if (theHouse.getHand().getSum() > thePlayer.getHand().getSum()) {
    endRound(2, false);
  }
  else if (theHouse.getHand().getSum() < thePlayer.getHand().getSum()) {
    endRound(1, false);
  }
  else if (theHouse.getHand().getSum() == thePlayer.getHand().getSum()) {
    endRound(3, false);
  }
}

void endRound(int mode, boolean wasBlackjack) {
  textSize(20);
  theHouse.getHand().getCard(0).setReveal(true); 
  if (mode == 1) {
    if (wasBlackjack) {
      thePlayer.addWallet((int)(thePlayer.getbet() * 1.5) + thePlayer.getbet());
    } 
    else {
      thePlayer.addWallet(thePlayer.getbet() * 2);
    }
    text("Lucky Ducky, I'll give you a little part of my vast fortune", 300, 450);
  } else if (mode == 2) {
    theHouse.getHand().getCard(0).setReveal(true);
    text("You Lose, I'll be taking your money. Please come again", 300, 450);
  } else if (mode == 3) {
    thePlayer.addWallet(thePlayer.getbet());
    text("It seems you've matched me! You'll lose when you play in the future", 300, 450);
  }
  thePlayer.makeBet(0);
  textSize(40);
  delay(500);
  text("Want to play again? \nPress R", 20, 700);
  roundOver = true;
}
