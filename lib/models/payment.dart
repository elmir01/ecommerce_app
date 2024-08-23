class Payment {
  final int? id;
  final String cardNumber;
  final int cvv;
  final String exp;
  final String cardHolderName;
  final int userId;

  Payment({
    this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.exp,
    required this.cvv,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cvv': cvv,
      'exp': exp,
      'cardHolderName': cardHolderName,
      'userId': userId,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'cardNumber': cardNumber,
      'cvv': cvv,
      'exp': exp,
      'cardHolderName': cardHolderName,
      'userId': userId
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      cardNumber: map['cardNumber'],
      cardHolderName: map['cardHolderName'],
      exp: map['exp'],
      cvv: map['cvv'],
      userId: map['userId'],
    );
  }
}
