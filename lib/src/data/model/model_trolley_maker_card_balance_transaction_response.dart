class CardBalanceAndTransactionResponse {
  final Map<String, CardTransactionData> cards;

  CardBalanceAndTransactionResponse({required this.cards});

  factory CardBalanceAndTransactionResponse.fromJson(
      Map<String, dynamic> json) {
    return CardBalanceAndTransactionResponse(
      cards: json.map(
        (key, value) => MapEntry(key, CardTransactionData.fromJson(value)),
      ),
    );
  }
}

class CardTransactionData {
  final List<Transaction> transactions;
  final Balance balance;

  CardTransactionData({
    required this.transactions,
    required this.balance,
  });

  factory CardTransactionData.fromJson(Map<String, dynamic> json) {
    return CardTransactionData(
      transactions: (json['transactions'] as List)
          .map((item) => Transaction.fromJson(item))
          .toList(),
      balance: Balance.fromJson(json['balance']),
    );
  }
}

class Transaction {
  final DateTime date;
  final String dateFormattedDE;
  final int amountCent;
  final int amountPositive;
  final String amountFormattedDE;
  final String partner;
  final String text;

  Transaction({
    required this.date,
    required this.dateFormattedDE,
    required this.amountCent,
    required this.amountPositive,
    required this.amountFormattedDE,
    required this.partner,
    required this.text,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: DateTime.parse(json['date']),
      dateFormattedDE: json['dateFormattedDE'],
      amountCent: json['amountCent'],
      amountPositive: json['amountPositive'],
      amountFormattedDE: json['amountFormattedDE'],
      partner: json['partner'],
      text: json['text'],
    );
  }
}

class Balance {
  final String balanceFormattedDE;
  final String balanceFormattedEN;
  final int balanceCent;

  Balance({
    required this.balanceFormattedDE,
    required this.balanceFormattedEN,
    required this.balanceCent,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      balanceFormattedDE: json['balanceFormattedDE'],
      balanceFormattedEN: json['balanceFormattedEN'],
      balanceCent: json['balanceCent'],
    );
  }
}