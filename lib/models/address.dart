class Address {
  final int? id;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final int userId;

  Address({
    this.id,
    required this.streetAddress,
    required this.state,
    required this.zipCode,
    required this.city,
    required this.userId,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'userId': userId,
    };
  }


  Map<String, dynamic> toMapWithoutId() {
    return {
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'userId': userId,
    };
  }


  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      streetAddress: map['streetAddress'],
      state: map['state'],
      zipCode: map['zipCode'],
      city: map['city'],
      userId: map['userId'],
    );
  }
}
