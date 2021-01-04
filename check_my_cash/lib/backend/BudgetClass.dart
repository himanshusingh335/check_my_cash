import 'transactions.dart';

class Budget {
  int bdjtAmount;
  int remainder;
  int amntSpent;
  var transactions = new List<Transactions>();

  int calculateRemainder() {
    remainder = bdjtAmount - amntSpent;
    return remainder;
  }

  int calculateAmntSpent() {
    for (int i = 0; i < transactions.length; i++) {
      amntSpent = amntSpent + transactions[i].transactionAmnt;
    }
    return amntSpent;
  }
}
