import 'package:ecommerce_app/views/home/product_detail_screen.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provider/favourite_provider.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    late final favourites = ref.watch(favouriteProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Wishlist (${favourites.length})'),

        ),
        body: GridView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: favourites.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0.sp,
            crossAxisSpacing: 11.0.sp,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProductDetailScreen(product: favourites[index])));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      // spreadRadius: 2,
                      blurRadius: 1,
                      // offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                            child: Image.asset(
                              '${favourites[index].images[0]}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200.sp,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  ref
                                      .read(favouriteProvider.notifier)
                                      .removeFromFavourite(favourites[index]);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          favourites[index].name,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${favourites[index].price}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
//favourites[index].name
//favourites[index].price
