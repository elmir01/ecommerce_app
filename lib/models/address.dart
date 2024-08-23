class Address {
  final int? id;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final int userId; // New field to associate the address with a user

  Address({
    this.id,
    required this.streetAddress,
    required this.state,
    required this.zipCode,
    required this.city,
    required this.userId, // Include userId in the constructor
  });

  // Convert Address object to Map (for inserting into the database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'userId': userId, // Include userId in the map
    };
  }

  // Convert Address object to Map without ID (useful for inserts)
  Map<String, dynamic> toMapWithoutId() {
    return {
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'userId': userId, // Include userId in the map
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
