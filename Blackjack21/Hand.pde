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
    else if (revealedCards == 0) {
      Card temp = masterDeck.getTopCard();
      temp.setReveal(false);
      currentHand.add(temp);
      Card temp1 = masterDeck.getTopCard();
      temp1.setReveal(false);
      currentHand.add(temp1);
    }
    else {
      currentHand.add(masterDeck.getTopCard());
      currentHand.add(masterDeck.getTopCard());
    }
    sum = currentHand.get(0).getValue() + currentHand.get(1).getValue();
    if (sum == 22) {
      sum = 12;
      currentHand.get(1).countedAs(1);
    }
  }
  
  public Hand(Card one) {
    currentHand = new ArrayList<Card>();
    currentHand.add(one);
    sum += one.getValue();
  }
  public Card getCard(int card) {
    return currentHand.get(card);
  }
  
  public int getHandLength() {
    return currentHand.size();
  }
  public int getSum() {
    return sum;
  }
  
  public void setSum(int num) {
    sum = num;
  }
  public Card removeCard(int card) {
    return currentHand.remove(card);
  }
  
  public boolean hasBlackjack() {
    boolean hasAce = currentHand.get(0).getValue() == 11 || currentHand.get(1).getValue() == 11;
    boolean has10 = currentHand.get(0).getValue() == 10 || currentHand.get(1).getValue() == 10;
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
    if (daDeck.size() < 5) {
        daDeck.refill();
    }
    Card daCard = masterDeck.getTopCard();
    if (sum < 21) { 
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
