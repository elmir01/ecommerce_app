
import 'package:ecommerce_app/models/product.dart';

class Cart {
  final int? id;
  final String size;
  final String color;
  final int quantity;
  final double price;
  final int listId;
  final String productJson;
  final String productName;
  final String productImage;
  final int userId;

  Cart({
    required this.userId,
    required this.productName,
    required this.productImage,
    required this.listId,
    this.id,
    required this.size,
    required this.quantity,
    required this.color,
    required this.productJson,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'listId': listId,
      'id': id,
      'color': color,
      'size': size,
      'quantity': quantity,
      'productJson': productJson,
      'price': price,
      'productImage': productImage,
      'productName': productName
    };
  }


  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      userId: map['userId'],
      productImage: map['productImage'],
      productName: map['productName'],
      price: map['price'],
      id: map['id'],
      listId: map['listId'],
      size: map['size'],
      quantity: map['quantity'],
      color: map['color'],
      productJson: map['productJson'],
    );
  }
}
