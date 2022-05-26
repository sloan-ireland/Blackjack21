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
  
  public boolean hasBlackjack() {
    boolean hasAce = false;
    boolean has10 = false;
    for (int i = 0; i < currentHand.size(); i++) {
      if (currentHand.get(i).getValue() == 11) {
        hasAce = true;
      }
      if (currentHand.get(i).getValue() == 10) {
        has10 = true;
      }
    }
    return hasAce && has10;
  }
  
  public boolean AceValChecker() {
  for (int i = 0; i < currentHand.size(); i++) {
    if (currentHand.get(i).getValue() == 11 && currentHand.get(i).countedAs() == 11) {
      return true;
    }
  }
  return false;
  }
  public void Hit(Deck daDeck) {
    Card daCard = masterDeck.getTopCard();
    if (daDeck.size() == 0) {
        daDeck.refill();
      }
    if (sum < 22) { 
      currentHand.add(daCard);
      if (daCard.getValue() == 11 && sum < 11) {
        sum += 11;
      }
      else if (daCard.getValue() == 11 && sum > 10) {
        sum += 1;
        currentHand.get(currentHand.size() -1).countedAs(1);
      }
      else {
        sum += daCard.getValue();
      }
      if (AceValChecker() && sum > 21) {
        sum -= 10;
        int counter = 0;
        int stop = 0;
        while (stop == 0) {
          if (currentHand.get(counter).countedAs() == 11) {
            currentHand.get(counter).countedAs(1);
            stop  = 1;
          }
          counter++;
        }
      }
    }
    
  }
  
  
  
}
