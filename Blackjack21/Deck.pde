import java.util.*;

public class Deck {
  
  private Deque<Card> deck; // Will be used a the card Deck
  
  public Deck() {
    refill();
  }
  
  /**
  Removes the top card in the stack and returns the card
  **/
  public Card getTopCard() {
    return deck.pop();
  }
  
  public int size() {
    return deck.size();
  }
  /**
  the deck is refilled with cards from 4 decks in random order
  **/
  public void refill() {
    ArrayList<Card> list = new ArrayList<Card>();
    String[] cards = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"};
    String[] suit = {"diamonds", "hearts", "clubs", "spades"};
    // This loop adds 4 sets of cards into the list
    for (int z = 0; z < 4; z++) {
      for (int i = 0; i < suit.length; i++) {
        for (int j = 0; j < cards.length; j++) {
          Card currentCard = new Card(suit[i], cards[j], true);
          list.add(currentCard);
        }
      }
    }
    Collections.shuffle(list); // list is randomly shuffled
    deck = new ArrayDeque<Card>(list); // the shuffled list now becomes a deck (stack)
  }
}
