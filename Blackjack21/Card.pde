public class Card {
  private String suit;
  private String value;
  private Boolean revealed;
  
  public Card(String suit1, String value1, boolean revealed1) {
    suit = suit1;
    value = value1;
    revealed = revealed1;
  }
  
  public int getValue() {
    if (value.equals("J") || value.equals("Q") || value.equals("K")) {
      return 10;
    }
    else if (value.equals("A")) {
      return 11;
    }
    else {
      return Integer.parseInt(value);
    }
  }
  
  public boolean isRevealed() {
    return revealed;
  }
  
}
