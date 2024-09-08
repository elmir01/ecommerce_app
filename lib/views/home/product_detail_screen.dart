import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:ecommerce_app/widgets/login_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_service.dart';
import '../../models/cart.dart';
import '../../provider/cart_notifier.dart';
import '../../provider/favourite_provider.dart';
import '../../provider/quantity_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  Product product;

  ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  var selectedSize = 'S';
  var selectedColor = 'Orange';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = widget.product;
    final quantity = ref.watch(quantityProvider);

    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(
                    255, 244, 244, 244),
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final isFavourite = ref
                      .watch(favouriteProvider.notifier)
                      .isFavourite(product);

                  return IconButton(
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        ref
                            .read(favouriteProvider.notifier)
                            .toggleFavourite(product);
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: product.images.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    print('productdetail');
                  },
                  child: Container(
                    width: 161.sp,
                    height: 248.sp,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            product.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 248.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 248.sp,
                viewportFraction: 0.42.sp,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                initialPage: 0,
                padEnds: false,
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Row(
                children: [
                  Text(
                    '\$${product.price.toString()}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color.fromARGB(255, 142, 108, 209),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  if (product.isDiscount == true)
                    Text(
                      '\$${product.disCountPrice}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Size',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.sp),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: product.sizes!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 7.0.sp),
                                    child: Container(
                                      width: 342.sp,
                                      height: 56.sp,
                                      child: Padding(
                                        padding: EdgeInsets.all(0.0.sp),
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              selectedSize =
                                                  product.sizes![index];
                                            });
                                            Navigator.pop(
                                                context, product.sizes![index]);
                                          },
                                          title: Text(
                                            product.sizes![index],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color: selectedSize ==
                                                      product.sizes![index]
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          trailing: selectedSize ==
                                                  product.sizes![index]
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedSize !=
                                                product.sizes![index]
                                            ? Color.fromARGB(255, 244, 244, 244)
                                            : Color.fromARGB(
                                                255, 142, 108, 209),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  ).then((selectedSize) {
                    if (selectedSize != null) {
                      setState(() {
                        this.selectedSize =
                            selectedSize;
                      });
                    }
                  });
                },
                child: Container(
                  width: 342.sp,
                  height: 56.sp,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 244, 244),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Size'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(selectedSize),
                              SizedBox(
                                width: 30.sp,
                              ),
                              Icon(Icons.expand_circle_down)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Color',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.sp),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: product.colors!.length,
                                itemBuilder: (
                                  context,
                                  int index,
                                ) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 7.0.sp),
                                    child: Container(
                                      width: 342.sp,
                                      height: 56.sp,
                                      child: Padding(
                                        padding: EdgeInsets.all(0.0.sp),
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              selectedColor = product
                                                  .colors!.keys
                                                  .elementAt(index);
                                            });
                                            Navigator.pop(
                                                context,
                                                product.colors!.keys
                                                    .elementAt(index));
                                          },
                                          title: Text(
                                            product.colors!.keys
                                                .elementAt(index),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color: selectedColor ==
                                                      product.colors!.keys
                                                          .elementAt(index)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          trailing: CircleAvatar(
                                            radius: 16.sp,
                                            backgroundColor: Color(int.parse(
                                                product.colors!.values
                                                    .elementAt(index))),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedColor !=
                                                product.colors!.keys
                                                    .elementAt(index)
                                            ? Color.fromARGB(255, 244, 244, 244)
                                            : Color.fromARGB(
                                                255, 142, 108, 209),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  ).then((selectedSize) {
                    if (selectedSize != null) {
                      setState(() {
                        this.selectedColor =
                            selectedColor;
                      });
                    }
                  });
                },
                child: Container(
                  width: 342.sp,
                  height: 56.sp,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 244, 244),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Color'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(selectedColor),
                              SizedBox(
                                width: 30.sp,
                              ),
                              Icon(Icons.expand_circle_down)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 342.sp,
                  height: 56.sp,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 244, 244),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity'),
                        SizedBox(
                          width: 20.sp,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(quantityProvider.notifier).decrement();
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 142, 108, 209),
                                radius: 15,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.sp,
                            ),
                            Text('$quantity'),
                            SizedBox(
                              width: 15.sp,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(quantityProvider.notifier).increment();
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 142, 108, 209),
                                radius: 15,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Text(
                product.description!,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int? userId = prefs.getInt('user_id');
            final productJson = jsonEncode(
                product.toMap());

            final cartItem = Cart(
              listId: 1,
              id: product.id,
              size: selectedSize,
              color: selectedColor,
              quantity: quantity,
              productJson: productJson,
              price: product.isDiscount == false
                  ? quantity * product.price
                  : quantity * product.disCountPrice!,
              productName: product.name,
              productImage: product.images[0], userId: userId!,

            );

            ref.read(cartProvider.notifier).addToCart(cartItem);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product added to cart')),
            );
          },
          child: Container(
            width: 342.sp,
            height: 60.sp,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 142, 108, 209),
              borderRadius: BorderRadius.all(
                Radius.circular(100.sp),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  product.isDiscount == false
                      ? Text(
                          '\$${(product.price * quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          '\$${(product.disCountPrice! * quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
