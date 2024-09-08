import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        leading: AppBarBackButton(),
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/emptycart.png'),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Image.asset('assets/emptycarttext.png')
                ],
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Dismissible(
                  key: ValueKey(cartItem.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ref
                        .read(cartProvider.notifier)
                        .removeFromCart(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${cartItem.productName} removed from cart'),
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
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Checkout'),
                  style: ElevatedButton.styleFrom(),
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
        elevation: 1.0,
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
                  cartNotifier.decreaseQuantity(cartItem);
                },
              ),
              Text('${cartItem.quantity}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cartNotifier.increaseQuantity(cartItem);
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
