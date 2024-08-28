// import 'package:ecommerce_app/widgets/appbar_back_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../models/product.dart';
//
// class CartScreen extends ConsumerStatefulWidget {
//   List<Product>? cartProducts;
//   int? quantity;
//   String? color;
//   String? size;
//
//   CartScreen(
//       {super.key, this.cartProducts, this.quantity, this.size, this.color});
//
//   @override
//   ConsumerState createState() => _CartScreenState();
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/cart.dart';
import '../../provider/cart_notifier.dart';

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    double totalPrice = cartItems.fold(
      0.0,
          (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Color.fromARGB(255, 142, 108, 209),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return Dismissible(
            key: ValueKey(cartItem.id), // Kart item-inin unikal id-si
            direction: DismissDirection.endToStart, // Sola sürüklemə
            onDismissed: (direction) {
              ref.read(cartProvider.notifier).removeFromCart(cartItem); // Silmə prosesi
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${cartItem.productName} removed from cart'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: CartItemTile(cartItem: cartItem),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Color.fromARGB(255, 142, 108, 209),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Burada ödəniş prosesini başlatmaq və ya başqa bir hərəkət etmək üçün kod əlavə edin
                  },
                  child: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                   
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemTile extends ConsumerWidget {
  final Cart cartItem;

  const CartItemTile({required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(cartProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        child: ListTile(
          leading: Image.asset(cartItem.productImage, width: 60, height: 60),
          title: Text(cartItem.productName),
          subtitle: Text(
            'Size: ${cartItem.size}\nColor: ${cartItem.color}',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  cartNotifier.decreaseQuantity(cartItem); // Miqdarı azalt
                },
              ),
              Text('${cartItem.quantity}', style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cartNotifier.increaseQuantity(cartItem); // Miqdarı artır
                },
              ),
              SizedBox(width: 16),
              Text(
                '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





