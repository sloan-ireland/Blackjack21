Deck masterDeck = new Deck();
Dealer theHouse = new Dealer();
Player thePlayer = new Player();
boolean roundOver = false;

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
  rect(250,5,500,75);
  fill(0);
  textSize(40);
  textAlign(CENTER);
  text(title, 500, 45);
  textSize(20);
  text("The House Always Wins! Play at your own risk :-)", 500,70);
}

void handSetup() {
  textAlign(LEFT);
  text("The Dealer", 450, 120);
  displayCards(theHouse.getHand(), 430, 130);
  text("Player", 470,700);
  displayCards(thePlayer.getHand(),430, 500);
}
void draw() {
  handSetup();
}

void keyPressed() {
  if (key == 's') {
    theHouse.getHand().getCard(0).setReveal(true);
  }
  if (key == 'h') {
    theHouse.getHand().getCard(0).setReveal(false);
    //theHouse.getHand().getCard(0).setReveal(false);
    thePlayer.getHand().Hit(masterDeck);
  }
}

void displayCards(Hand daHand, float x, float y) {
  for (int i = 0, j = 0; i < daHand.getHandLength(); i++, j += 50) {
    PImage card = loadImage("Cards/" + daHand.getCard(i).getImageString());
    card.resize(180, 261);
    if (daHand.getCard(i).isRevealed()) {
      image(card, x +j, y);
    }
    else {
      image(back,x +j ,y);
    }
  }
}

void checkBlackjack() {
  boolean playerBJ = thePlayer.getHand().hasBlackjack();
  boolean houseBJ = theHouse.getHand().hasBlackjack();
  if (playerBJ && !houseBJ) {
    //thePlayer.addWallet((int)(thePlayer.getbet() * 1.5));
    endRound(1);
  } else if (!playerBJ && houseBJ) {
    endRound(2);
  } else if (playerBJ && houseBJ) {
    //thePlayer.addWallet(thePlayer.getbet());
    endRound(3);
  } else {
    play();
  }
}

void play() {
  
}

void endRound(int mode) {
}
