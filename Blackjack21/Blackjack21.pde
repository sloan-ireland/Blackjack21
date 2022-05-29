Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();
boolean roundOver = false;
boolean playerTurn = true;

PImage back; 

void setup() {
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
  text("The Dealer", 450, 120);
  displayCards(theHouse.getHand(), 430, 130);
  text("Player", 470, 700);
  displayCards(thePlayer.getHand(), 430, 500);
}
void draw() {
  handSetup();
  text("Sum: " + thePlayer.getHand().getSum(), 800, 800);
}

void keyPressed() {
  if (playerTurn) { 
    if (key == 's') {
      playerTurn = false;
      play();
    }
    if (key == 'h') {
      thePlayer.getHand().Hit(masterDeck);
      if (thePlayer.getHand().getSum() > 21) {
        endRound(2, false);
        playerTurn = false;
      }
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
  playerTurn = false;
  boolean playerBJ = thePlayer.getHand().hasBlackjack();
  boolean houseBJ = theHouse.getHand().hasBlackjack();
  if (playerBJ && !houseBJ) {
    endRound(1, true);
  } else if (!playerBJ && houseBJ) {
    endRound(2, true);
  } else if (playerBJ && houseBJ) {
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
  if (mode == 1) {
    if (wasBlackjack) {
      thePlayer.addWallet((int)(thePlayer.getbet() * 1.5) + thePlayer.getbet());
    } 
    else {
      thePlayer.addWallet(thePlayer.getbet() * 2);
    }
    text("Lucky Ducky, I'll give you a little of my vast part of my fortune", 500, 500);
  } else if (mode == 2) {
    theHouse.getHand().getCard(0).setReveal(true);
    text("You Lose, I'll be taking your money. Please come again", 500, 500);
  } else if (mode == 3) {
    thePlayer.addWallet(thePlayer.getbet());
    text("Better luck next time. You'll lose when you play in the future", 500, 500);
  }
  thePlayer.makeBet(0);
}
