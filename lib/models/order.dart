import 'package:ecommerce_app/models/product.dart';

class Order {
  final int id;
  final List<Product> products;
  final double totalPrice;

  Order({
    required this.id,
    required this.products,
    required this.totalPrice,
  });

  // Convert an Order object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((product) => product.toMap()).toList(),
      'totalPrice': totalPrice,
    };
  }

  // Convert a Map object into an Order object
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      products: List<Product>.from(
        (map['products'] as List).map((item) => Product.fromMap(item)),
      ),
      totalPrice: map['totalPrice'],
    );
  }
}
