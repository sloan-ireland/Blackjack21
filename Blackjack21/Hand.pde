import java.util.*;
public class Hand {
  private int sum;
  private ArrayList<Card> currentHand;
  
  public Hand(int revealedCards) {
    currentHand = new ArrayList<Card>();
    if (revealedCards == 1) {
      Card temp = masterDeck.getTopCard();
      temp.setReveal(false);
      currentHand.add(temp);
      currentHand.add(masterDeck.getTopCard());
    }
    else {
      currentHand.add(masterDeck.getTopCard());
      currentHand.add(masterDeck.getTopCard());
    }
    sum = currentHand.get(0).getValue() + currentHand.get(1).getValue();
  }
  
  public int getSum() {
    return sum;
  }
  /*
  public void Hit(Deck daDeck) {
    Card daCard = masterDeck.getTopCard();
    if (sum < 22) { 
      if (daDeck.size() == 0) {
        daDeck.refill();
      }
      currentHand.add(daCard);
      if (daCard.getValue() != 11) {
        
      }
    }
    
  }
  */
  
  
  
}
