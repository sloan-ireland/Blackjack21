public class Player {
  private Hand currentHand; // the player's hand
  private int bet; 
  private int wallet;
  
  public Player() {
    currentHand = new Hand(2);
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
  Withdraw bet amount from wallet and changes bet to the bet value
  IllegalArgumentException is thrown: bet is greater than the wallet
  **/
  public void makeBet(int currentBet) {
    if (currentBet > wallet) {
      throw new IllegalArgumentException("You poor person. Make a bet you can afford!");
    }
    wallet = wallet - currentBet;
    bet = currentBet;
  }
}  
