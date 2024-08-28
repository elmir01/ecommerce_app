import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';


class CartState {
  final List<Cart> cartItems;

  CartState(this.cartItems);

  CartState copyWith({List<Cart>? cartItems}) {
    return CartState(cartItems ?? this.cartItems);
  }
}
