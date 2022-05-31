public class Dealer {
  private Hand theHouse; // The dealer's hand
  
  public Dealer() {
    theHouse = new Hand(0);
  }
  
  public Hand getHand() {
    return theHouse;
  }
}
