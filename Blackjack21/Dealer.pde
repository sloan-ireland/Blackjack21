public class Dealer {
  private Hand theHouse; // The dealer's hand
  
  public Dealer() {
    theHouse = new Hand(1);
  }
  
  public Hand getHand() {
    return theHouse;
  }
}
