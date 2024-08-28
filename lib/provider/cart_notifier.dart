import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/models/product.dart';

import '../models/cart.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Cart>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  void addToCart(Cart cart) {
    state = [...state, cart];
  }

  void removeFromCart(Cart cart) {
    state = state.where((p) => p.id != cart.id).toList();
  }

  void increaseQuantity(Cart cartItem) {
    state = state.map((item) {
      if (item == cartItem) {
        return Cart(
          productName: item.productName,
          productImage: item.productImage,
          price: item.price,
          quantity: item.quantity + 1,
          size: item.size,
          color: item.color,
          listId: item.listId,
          productJson: item.productJson,
        );
      }
      return item;
    }).toList();
  }

  void decreaseQuantity(Cart cartItem) {
    state = state.map((item) {
      if (item == cartItem) {
        if (item.quantity > 1) {
          return Cart(
            productName: item.productName,
            productImage: item.productImage,
            price: item.price,
            quantity: item.quantity - 1,
            size: item.size,
            color: item.color,
            listId: item.listId,
            productJson: item.productJson,
          );
        }
        return item; // Miqdar 1-dən az olmamalıdır
      }
      return item;
    }).toList();
  }

  List<Cart> get cartItems => state;
}
