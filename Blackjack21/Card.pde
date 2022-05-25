public class Card {
  private String suit;
  private String value;
  private Boolean revealed;
  private boolean isAce;
  private int countedAs;
  
  public Card(String suit1, String value1, boolean revealed1) {
    suit = suit1;
    value = value1;
    revealed = revealed1;
    if (value1.equals("A")) {
      isAce = true;
      countedAs = 11;
    }
    else {
      isAce = false;
      countedAs = 0; 
    }
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
  
  public void setValue(String newVal) {
    value = newVal;    
  }
  
  public void setReveal(boolean reveal) {
    revealed = reveal;
  }
  
  public void countedAs(int val) {
    countedAs = val;
  }
  
  public int countedAs() {
    return countedAs;
  }
  
  public boolean isAce() {
    return isAce;
  }
}
