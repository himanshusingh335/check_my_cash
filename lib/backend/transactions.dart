class Transactions {
  var transactionDate;
  var transactionAmnt;
  var reason;
  var id;

  Transactions(
      {this.transactionDate, this.transactionAmnt, this.reason, this.id});

  Transactions.withoutid(
      {this.transactionDate, this.transactionAmnt, this.reason});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': transactionDate,
      'amount': transactionAmnt,
      'reason': reason,
    };
  }
}
