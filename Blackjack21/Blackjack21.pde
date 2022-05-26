Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();

void setup() {
  size(1000,800);
  background(#39FF14);
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
