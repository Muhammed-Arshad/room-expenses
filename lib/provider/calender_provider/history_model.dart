class Purchase {
  final String date;
  final String amount;
  final String id;

  Purchase({required this.date, required this.amount,required this.id});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      date: json['date'] ?? '',
      amount: json['amount'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'id': id,
    };
  }
}