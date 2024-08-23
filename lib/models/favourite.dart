class Favourite {
  final int? id;
  final int productId;
  final int listId;

  Favourite({this.id, required this.productId,required this.listId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listId': listId,
      'productId': productId,
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
      id: map['id'],
      listId: map['listId'],
      productId: map['productId'],
    );
  }
}
