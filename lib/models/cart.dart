// import 'package:ecommerce_app/models/product.dart';
//
// class Cart {
//   final int? id;
//   final String size;
//   final String color;
//   final int quantity;
//   final int listId;
//   final Product product;
//
//   Cart({
//
//     required this.listId,
//     this.id,
//     required this.size,
//     required this.quantity,
//     required this.color,
//     required this.product,
//   });
//
//   // Convert an Order object into a Map object
//   Map<String, dynamic> toMap() {
//     return {
//
//       'listId': listId,
//       'id': id,
//       'color': color,
//       'size': size,
//       'quantity': quantity,
//       'product': product,
//       // 'products': products.map((product) => product.toMap()).toList(),
//     };
//   }
//
//   // Convert a Map object into an Order object
//   factory Cart.fromMap(Map<String, dynamic> map) {
//     return Cart(
//       id: map['id'],
//       // products: List<Product>.from(
//       //   (map['products'] as List).map((item) => Product.fromMap(item)),
//       // ),
//       listId: map['listId'],
//       size: map['size'],
//       quantity: map['quantity'],
//       color: map['color'],
//       product: map['product'],
//     );
//   }
// }


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
  final String productImage;// JSON stringi saxlayır

  Cart({
    required this.productName,
    required this.productImage,
    required this.listId,
    this.id,
    required this.size,
    required this.quantity,
    required this.color,
    required this.productJson,
    required this.price,// JSON stringi
  });

  // Convert a Cart object into a Map object
  Map<String, dynamic> toMap() {
    return {
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

  // Convert a Map object into a Cart object
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
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
