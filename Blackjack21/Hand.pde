import java.util.*;
public class Hand {
  private int sum;
  private ArrayList<Card> currentHand;
  
  public Hand(int revealedCards) {
    if (revealedCards == 1) {
      Card temp = daDeck.getTopCard();
      temp.setReveal(false);
      currentHand.add(temp);
      currentHand.add(daDeck.getTopCard());
    }
    else {
      currentHand.add(daDeck.getTopCard());
      currentHand.add(daDeck.getTopCard());
    }
  }
}
