Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();

void setup() {
  size(1000,800);
  background(#39FF14);
  //Card check = masterDeck.getTopCard();
  //PImage card;
  //card = loadImage("Cards/"+check.getImageString());
  //card.resize(100,140);
  //image(card,0,0);
  
  for (int i = 0; i < masterDeck.size(); i++) {
    Card check = masterDeck.getTopCard();
    PImage card;
    card = loadImage("Cards/"+check.getImageString());
    card.resize(100,145);
    image(card,(i*120),0);
  }
}


void draw() {

}

void checkBlackjack() {
  boolean playerBJ = thePlayer.getHand().hasBlackjack();
  boolean houseBJ = theHouse.getHand().hasBlackjack();
  if (playerBJ && !houseBJ) {
    thePlayer.addWallet((int)(thePlayer.getbet() * 1.5));
  }
  else if (playerBJ && houseBJ) {
    thePlayer.addWallet(thePlayer.getbet());
  }
  else {
    play();
  }
}

void play() {

}

void endRound(int mode) {

}
