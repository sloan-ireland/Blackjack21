public class Player {
  private Hand currentHand; // the player's hand
  private int bet; 
  private int wallet;
  
  public Player() {
    currentHand = new Hand(0);
    bet = 0;
    wallet = 500;
  }
  
  
  /**
  returns the value of the bet
  **/
  public int getbet() {
    return bet;
  }
  
  
  /**
  returns the value of the wallet
  **/
  public int getWallet() {
    return wallet;
  }
  
  
  /**
  Adds an amount to the wallet (could be negative for subtraction)
  **/
  public void addWallet(int amount) {
    wallet += amount;
  }
  
  
  /**
  returns the Hand of the player
  **/
  public Hand getHand() {
    return currentHand;
  }
  
  public void setHand(Hand dahand) {
    currentHand = dahand;
  }
  
  
  public void makeBet(int currentBet) {
    if (currentBet > wallet) {
      bet = 0;
      messageCenter("You poor person. \nMake a bet you can afford!");
    }
    else if (wallet == 0) {
      noLoop();
      delay(1000);
      background(0);
      clear();
      fill(255);
      textSize(70);
      textAlign(CENTER);
      text("You incompetent person. \nYou have no money. \nGo cry in a hole", width / 2,200);
    }
    else {
    wallet = wallet - currentBet;
    bet = currentBet;
    }
  }
}  
